import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/domain/entities/recording.dart';
import 'package:scribble/app/domain/entities/segment.dart';

/// Parameters for creating a new recording
class CreateRecordingParams {
  final String title;
  final RecordingMode mode;
  final String clientCode;
  
  const CreateRecordingParams({
    required this.title,
    required this.mode,
    required this.clientCode,
  });
}

/// Parameters for updating recording status
class UpdateRecordingStatusParams {
  final String recordingId;
  final RecordingStatus status;
  final int? totalDurationMs;
  final int? totalParts;
  final String? computedHashKey;
  final String? metadataJson;
  
  const UpdateRecordingStatusParams({
    required this.recordingId,
    required this.status,
    this.totalDurationMs,
    this.totalParts,
    this.computedHashKey,
    this.metadataJson,
  });
}

/// Repository interface for recording operations
abstract class RecordingRepository {
  /// Create a new recording
  Future<Result<Recording>> createRecording(CreateRecordingParams params);
  
  /// Get a recording by ID
  Future<Result<Recording>> getRecording(String id);
  
  /// Update recording status and metadata
  Future<Result<Recording>> updateRecordingStatus(UpdateRecordingStatusParams params);
  
  /// Add a segment to a recording
  Future<Result<Segment>> addSegment({
    required String recordingId,
    required int index,
    required DateTime startedAt,
  });
  
  /// Update segment (pause, resume, stop)
  Future<Result<Segment>> updateSegment({
    required String segmentId,
    DateTime? pausedAt,
    DateTime? resumedAt,
    DateTime? stoppedAt,
    String? filePath,
  });
  
  /// Get all segments for a recording
  Future<Result<List<Segment>>> getSegments(String recordingId);
  
  /// Get all recordings
  Future<Result<List<Recording>>> getAllRecordings();
  
  /// Watch all recordings (reactive stream)
  Stream<List<Recording>> watchAllRecordings();
  
  /// Watch a specific recording (reactive stream)
  Stream<Recording> watchRecording(String id);
  
  /// Get active recording (status = recording)
  Future<Result<Recording?>> getActiveRecording();
  
  /// Get paused recordings
  Future<Result<List<Recording>>> getPausedRecordings();
  
  /// Delete a recording
  Future<Result<void>> deleteRecording(String id);
}
