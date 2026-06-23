import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/domain/entities/upload_job.dart';

/// Parameters for creating an upload job
class CreateUploadJobParams {
  final String recordingId;
  final int totalChunks;
  
  const CreateUploadJobParams({
    required this.recordingId,
    required this.totalChunks,
  });
}

/// Parameters for updating upload job progress
class UpdateUploadJobParams {
  final String jobId;
  final UploadJobStatus? status;
  final int? uploadedChunks;
  final DateTime? lastAttemptAt;
  
  const UpdateUploadJobParams({
    required this.jobId,
    this.status,
    this.uploadedChunks,
    this.lastAttemptAt,
  });
}

/// Repository interface for queue/upload job operations
abstract class QueueRepository {
  /// Create a new upload job
  Future<Result<UploadJob>> createUploadJob(CreateUploadJobParams params);
  
  /// Get an upload job by ID
  Future<Result<UploadJob>> getUploadJob(String id);
  
  /// Get upload job for a recording
  Future<Result<UploadJob?>> getUploadJobForRecording(String recordingId);
  
  /// Update upload job
  Future<Result<UploadJob>> updateUploadJob(UpdateUploadJobParams params);
  
  /// Increment uploaded chunks count
  Future<Result<UploadJob>> incrementUploadedChunks(String jobId);
  
  /// Get all pending upload jobs
  Future<Result<List<UploadJob>>> getPendingJobs();
  
  /// Get all active upload jobs
  Future<Result<List<UploadJob>>> getActiveJobs();
  
  /// Watch upload job (reactive stream)
  Stream<UploadJob> watchUploadJob(String id);
  
  /// Watch all upload jobs
  Stream<List<UploadJob>> watchAllUploadJobs();
  
  /// Delete upload job
  Future<Result<void>> deleteUploadJob(String id);
}
