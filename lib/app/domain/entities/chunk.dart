import 'package:scribble/app/core/constants/app_constants.dart';

/// UploadChunk entity - represents an encrypted upload chunk (aggregated cipher chunks)
/// 
/// Two-level chunking model:
/// - Level 1: Cipher chunks (8192 bytes) - for AES-GCM encryption alignment
/// - Level 2: Upload chunks (5-10 MB) - for network efficiency (THIS ENTITY)
/// 
/// Each UploadChunk aggregates multiple cipher chunks for efficient network transfer
class UploadChunk {
  final String id;
  final String recordingId;
  final String? segmentId;
  final int sequence;              // Upload sequence number (0, 1, 2, ...)
  final int startCipherIndex;      // First cipher chunk index in this upload
  final int endCipherIndex;        // Last cipher chunk index in this upload
  final ChunkStatus status;
  final int retryCount;
  final String? encryptedFilePath; // Aggregated encrypted file path
  final int sizeBytes;             // Actual file size in bytes
  final String? hash;              // SHA-256 hash of aggregated chunk
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const UploadChunk({
    required this.id,
    required this.recordingId,
    this.segmentId,
    required this.sequence,
    required this.startCipherIndex,
    required this.endCipherIndex,
    required this.status,
    this.retryCount = 0,
    this.encryptedFilePath,
    required this.sizeBytes,
    this.hash,
    required this.createdAt,
    required this.updatedAt,
  });
  
  /// Create a copy with updated fields
  UploadChunk copyWith({
    String? id,
    String? recordingId,
    String? segmentId,
    int? sequence,
    int? startCipherIndex,
    int? endCipherIndex,
    ChunkStatus? status,
    int? retryCount,
    String? encryptedFilePath,
    int? sizeBytes,
    String? hash,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UploadChunk(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      segmentId: segmentId ?? this.segmentId,
      sequence: sequence ?? this.sequence,
      startCipherIndex: startCipherIndex ?? this.startCipherIndex,
      endCipherIndex: endCipherIndex ?? this.endCipherIndex,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      encryptedFilePath: encryptedFilePath ?? this.encryptedFilePath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      hash: hash ?? this.hash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  /// Get number of cipher chunks in this upload chunk
  int get cipherChunkCount => endCipherIndex - startCipherIndex + 1;
  
  /// Check if chunk can be retried
  bool canRetry(int maxRetries) => retryCount < maxRetries;
  
  /// Get next retry delay with exponential backoff
  Duration getNextRetryDelay() {
    final delay = AppConstants.initialRetryDelay * 
        (AppConstants.retryBackoffMultiplier * retryCount);
    return delay > AppConstants.maxRetryDelay 
        ? AppConstants.maxRetryDelay 
        : delay;
  }
  
  /// Transition to next status in the state machine
  ChunkStatus? nextStatus() {
    return switch (status) {
      ChunkStatus.pending => ChunkStatus.encrypting,
      ChunkStatus.encrypting => ChunkStatus.ready,
      ChunkStatus.ready => ChunkStatus.uploading,
      ChunkStatus.uploading => ChunkStatus.uploaded,
      ChunkStatus.uploaded => ChunkStatus.confirmed,
      ChunkStatus.confirmed => null, // Terminal state
      ChunkStatus.failed => ChunkStatus.pending, // Retry
      ChunkStatus.dead => null, // Terminal state
    };
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadChunk &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'UploadChunk(id: $id, recordingId: $recordingId, sequence: $sequence, status: $status, size: ${sizeBytes}B, cipherChunks: $startCipherIndex-$endCipherIndex)';
  }
}
