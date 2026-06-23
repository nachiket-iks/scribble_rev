import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/core/error/failures.dart';
import 'package:scribble/app/domain/entities/recording.dart';
import 'package:scribble/app/domain/repositories/recording_repository.dart';

/// Use case: Pause an active recording
class PauseRecordingUseCase {
  final RecordingRepository _repository;
  
  PauseRecordingUseCase({required RecordingRepository repository})
      : _repository = repository;
  
  Future<Result<Recording>> call(String recordingId) async {
    try {
      // Get recording
      final recordingResult = await _repository.getRecording(recordingId);
      if (recordingResult.isFailure) {
        return Result.failure(recordingResult.failureOrNull!);
      }
      
      final recording = recordingResult.dataOrNull!;
      
      // Validate recording is active
      if (!recording.status.isActive) {
        return Result.failure(
          ValidationFailure(
            message: 'Cannot pause: recording is not active (status: ${recording.status})',
          ),
        );
      }
      
      // Update status to paused
      return await _repository.updateRecordingStatus(
        UpdateRecordingStatusParams(
          recordingId: recordingId,
          status: RecordingStatus.paused,
        ),
      );
    } catch (e) {
      return Result.failure(
        UnknownFailure(
          message: 'Failed to pause recording',
          originalError: e,
        ),
      );
    }
  }
}

/// Use case: Resume a paused recording
class ResumeRecordingUseCase {
  final RecordingRepository _repository;
  
  ResumeRecordingUseCase({required RecordingRepository repository})
      : _repository = repository;
  
  Future<Result<Recording>> call(String recordingId) async {
    try {
      // Get recording
      final recordingResult = await _repository.getRecording(recordingId);
      if (recordingResult.isFailure) {
        return Result.failure(recordingResult.failureOrNull!);
      }
      
      final recording = recordingResult.dataOrNull!;
      
      // Validate recording is paused
      if (!recording.status.canResume) {
        return Result.failure(
          ValidationFailure(
            message: 'Cannot resume: recording is not paused (status: ${recording.status})',
          ),
        );
      }
      
      // Check if there's an active recording
      final activeResult = await _repository.getActiveRecording();
      if (activeResult.isFailure) {
        return Result.failure(activeResult.failureOrNull!);
      }
      
      if (activeResult.dataOrNull != null) {
        return Result.failure(
          const ValidationFailure(
            message: 'Cannot resume: another recording is active. Please pause it first.',
          ),
        );
      }
      
      // Get segments to determine next index
      final segmentsResult = await _repository.getSegments(recordingId);
      if (segmentsResult.isFailure) {
        return Result.failure(segmentsResult.failureOrNull!);
      }
      
      final segments = segmentsResult.dataOrNull!;
      final nextIndex = segments.length;
      
      // Create new segment for resumed recording
      await _repository.addSegment(
        recordingId: recordingId,
        index: nextIndex,
        startedAt: DateTime.now(),
      );
      
      // Update status to recording
      return await _repository.updateRecordingStatus(
        UpdateRecordingStatusParams(
          recordingId: recordingId,
          status: RecordingStatus.recording,
        ),
      );
    } catch (e) {
      return Result.failure(
        UnknownFailure(
          message: 'Failed to resume recording',
          originalError: e,
        ),
      );
    }
  }
}

/// Use case: Stop a recording and trigger finalization
class StopRecordingUseCase {
  final RecordingRepository _repository;
  
  StopRecordingUseCase({required RecordingRepository repository})
      : _repository = repository;
  
  Future<Result<Recording>> call(String recordingId) async {
    try {
      // Get recording
      final recordingResult = await _repository.getRecording(recordingId);
      if (recordingResult.isFailure) {
        return Result.failure(recordingResult.failureOrNull!);
      }
      
      final recording = recordingResult.dataOrNull!;
      
      // Validate recording can be stopped
      if (recording.status == RecordingStatus.stopped ||
          recording.status == RecordingStatus.done) {
        return Result.failure(
          ValidationFailure(
            message: 'Recording is already stopped or done',
          ),
        );
      }
      
      // Update status to stopped (processing will be triggered by strategy)
      return await _repository.updateRecordingStatus(
        UpdateRecordingStatusParams(
          recordingId: recordingId,
          status: RecordingStatus.stopped,
        ),
      );
    } catch (e) {
      return Result.failure(
        UnknownFailure(
          message: 'Failed to stop recording',
          originalError: e,
        ),
      );
    }
  }
}
