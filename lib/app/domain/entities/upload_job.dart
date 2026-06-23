import 'package:scribble/app/core/constants/app_constants.dart';

/// UploadJob entity - tracks upload progress for a recording
class UploadJob {
  final String id;
  final String recordingId;
  final UploadJobStatus status;
  final int totalChunks;
  final int uploadedChunks;
  final DateTime? lastAttemptAt;
  final DateTime createdAt;
  
  const UploadJob({
    required this.id,
    required this.recordingId,
    required this.status,
    required this.totalChunks,
    this.uploadedChunks = 0,
    this.lastAttemptAt,
    required this.createdAt,
  });
  
  /// Create a copy with updated fields
  UploadJob copyWith({
    String? id,
    String? recordingId,
    UploadJobStatus? status,
    int? totalChunks,
    int? uploadedChunks,
    DateTime? lastAttemptAt,
    DateTime? createdAt,
  }) {
    return UploadJob(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      status: status ?? this.status,
      totalChunks: totalChunks ?? this.totalChunks,
      uploadedChunks: uploadedChunks ?? this.uploadedChunks,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  /// Calculate upload progress percentage (0-100)
  double get progressPercentage {
    if (totalChunks == 0) return 0.0;
    return (uploadedChunks / totalChunks) * 100.0;
  }
  
  /// Check if upload is complete
  bool get isComplete => uploadedChunks >= totalChunks;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadJob &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'UploadJob(id: $id, recordingId: $recordingId, status: $status, progress: ${progressPercentage.toStringAsFixed(1)}%)';
  }
}
