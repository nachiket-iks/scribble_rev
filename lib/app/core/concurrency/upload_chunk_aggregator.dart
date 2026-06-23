import 'dart:io';
import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/core/error/failures.dart';
import 'package:scribble/app/domain/entities/chunk.dart';
import 'package:uuid/uuid.dart';

/// Service for aggregating cipher chunks into upload chunks
/// 
/// Two-level chunking model:
/// - Level 1: Cipher chunks (8192 bytes) - for AES-GCM encryption alignment
/// - Level 2: Upload chunks (5-10 MB) - for network efficiency
/// 
/// This service reads encrypted cipher chunk files and aggregates them
/// into larger upload chunks suitable for network transfer.
class UploadChunkAggregator {
  final Uuid _uuid;
  
  UploadChunkAggregator() : _uuid = const Uuid();
  
  /// Aggregate cipher chunk files into upload chunks
  /// 
  /// [recordingId] - The recording these chunks belong to
  /// [cipherChunkFiles] - List of encrypted cipher chunk file paths (in order)
  /// [targetUploadSize] - Target size for upload chunks (adaptive based on network)
  /// [outputDir] - Directory to write aggregated upload chunk files
  /// 
  /// Returns list of UploadChunk entities ready for upload
  Future<Result<List<UploadChunk>>> aggregateCipherChunks({
    required String recordingId,
    required List<String> cipherChunkFiles,
    required int targetUploadSize,
    required String outputDir,
    String? segmentId,
  }) async {
    try {
      if (cipherChunkFiles.isEmpty) {
        return Result.success([]);
      }
      
      // Ensure output directory exists
      final outDir = Directory(outputDir);
      if (!await outDir.exists()) {
        await outDir.create(recursive: true);
      }
      
      final uploadChunks = <UploadChunk>[];
      int currentSequence = 0;
      int cipherChunkIndex = 0;
      
      while (cipherChunkIndex < cipherChunkFiles.length) {
        // Aggregate cipher chunks until we reach target size
        final startIndex = cipherChunkIndex;
        final aggregatedFiles = <String>[];
        int aggregatedSize = 0;
        
        // Collect cipher chunks for this upload chunk
        while (aggregatedSize < targetUploadSize && 
               cipherChunkIndex < cipherChunkFiles.length) {
          final file = File(cipherChunkFiles[cipherChunkIndex]);
          
          if (!await file.exists()) {
            return Result.failure(FileSystemFailure(
              message: 'Cipher chunk file not found: ${file.path}',
            ));
          }
          
          final fileSize = await file.length();
          aggregatedFiles.add(file.path);
          aggregatedSize += fileSize;
          cipherChunkIndex++;
        }
        
        // Create aggregated upload chunk file
        final uploadChunkId = _uuid.v4();
        final uploadChunkPath = '$outputDir/upload_chunk_${currentSequence}_$uploadChunkId.xsba';
        final uploadChunkFile = File(uploadChunkPath);
        
        // Concatenate cipher chunk files
        final sink = uploadChunkFile.openWrite();
        try {
          for (final cipherFile in aggregatedFiles) {
            final bytes = await File(cipherFile).readAsBytes();
            sink.add(bytes);
          }
          await sink.flush();
        } finally {
          await sink.close();
        }
        
        // Verify aggregated file size
        final actualSize = await uploadChunkFile.length();
        
        // Create UploadChunk entity
        final now = DateTime.now();
        final uploadChunk = UploadChunk(
          id: uploadChunkId,
          recordingId: recordingId,
          segmentId: segmentId,
          sequence: currentSequence,
          startCipherIndex: startIndex,
          endCipherIndex: cipherChunkIndex - 1,
          status: ChunkStatus.ready, // Ready for upload
          encryptedFilePath: uploadChunkPath,
          sizeBytes: actualSize,
          createdAt: now,
          updatedAt: now,
        );
        
        uploadChunks.add(uploadChunk);
        currentSequence++;
      }
      
      return Result.success(uploadChunks);
    } catch (e) {
      return Result.failure(UnknownFailure(
        message: 'Failed to aggregate cipher chunks',
        originalError: e,
      ));
    }
  }
  
  /// Calculate optimal upload chunk size based on network quality
  int getOptimalUploadSize(NetworkQuality networkQuality) {
    return networkQuality.uploadChunkSize;
  }
  
  /// Estimate number of upload chunks that will be created
  int estimateUploadChunkCount({
    required int totalCipherChunks,
    required int targetUploadSize,
  }) {
    final avgCipherChunkSize = AppConstants.cipherChunkSize + 
                                AppConstants.nonceSize + 
                                AppConstants.tagSize; // ~8KB with overhead
    
    final totalBytes = totalCipherChunks * avgCipherChunkSize;
    final uploadChunkCount = (totalBytes / targetUploadSize).ceil();
    
    return uploadChunkCount;
  }
  
  /// Clean up cipher chunk files after successful aggregation
  Future<Result<void>> cleanupCipherChunks(List<String> cipherChunkFiles) async {
    try {
      for (final filePath in cipherChunkFiles) {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      }
      return Result.success(null);
    } catch (e) {
      return Result.failure(FileSystemFailure(
        message: 'Failed to cleanup cipher chunks',
        originalError: e,
      ));
    }
  }
}
