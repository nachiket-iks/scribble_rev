import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/domain/entities/chunk.dart';

/// Parameters for creating a new upload chunk
class CreateUploadChunkParams {
  final String recordingId;
  final String? segmentId;
  final int sequence;
  final int startCipherIndex;
  final int endCipherIndex;
  final int sizeBytes;
  
  const CreateUploadChunkParams({
    required this.recordingId,
    this.segmentId,
    required this.sequence,
    required this.startCipherIndex,
    required this.endCipherIndex,
    required this.sizeBytes,
  });
}

/// Parameters for updating upload chunk status
class UpdateChunkStatusParams {
  final String chunkId;
  final ChunkStatus status;
  final String? encryptedFilePath;
  final String? hash;
  final int? retryCount;
  
  const UpdateChunkStatusParams({
    required this.chunkId,
    required this.status,
    this.encryptedFilePath,
    this.hash,
    this.retryCount,
  });
}

/// Repository interface for upload chunk operations
abstract class ChunkRepository {
  /// Create a new upload chunk
  Future<Result<UploadChunk>> createChunk(CreateUploadChunkParams params);
  
  /// Get a chunk by ID
  Future<Result<UploadChunk>> getChunk(String id);
  
  /// Update chunk status (state machine transition)
  Future<Result<UploadChunk>> updateChunkStatus(UpdateChunkStatusParams params);
  
  /// Get all upload chunks for a recording (ordered by sequence)
  Future<Result<List<UploadChunk>>> getChunksForRecording(String recordingId);
  
  /// Get chunks by status (ordered by sequence)
  Future<Result<List<UploadChunk>>> getChunksByStatus(ChunkStatus status);
  
  /// Get pending chunks (ready for processing)
  Future<Result<List<UploadChunk>>> getPendingChunks();
  
  /// Get ready chunks (encrypted, ready for upload)
  Future<Result<List<UploadChunk>>> getReadyChunks();
  
  /// Watch chunks for a recording (reactive stream, ordered by sequence)
  Stream<List<UploadChunk>> watchChunksForRecording(String recordingId);
  
  /// Watch chunk status changes
  Stream<UploadChunk> watchChunk(String id);
  
  /// Delete chunks for a recording
  Future<Result<void>> deleteChunksForRecording(String recordingId);
  
  /// Increment retry count for a chunk
  Future<Result<UploadChunk>> incrementRetryCount(String chunkId);
  
  /// Mark chunk as dead (exceeded max retries)
  Future<Result<UploadChunk>> markChunkAsDead(String chunkId);
}
