import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/core/error/failures.dart';
import 'package:scribble/app/domain/entities/recording.dart';
import 'package:scribble/app/domain/repositories/recording_repository.dart';
import 'package:uuid/uuid.dart';

/// Parameters for starting a recording
class StartRecordingParams {
  final String title;
  final RecordingMode mode;
  final String clientCode;
  
  const StartRecordingParams({
    required this.title,
    required this.mode,
    required this.clientCode,
  });
}

/// Use case: Start a new recording
/// S - Single Responsibility: Only handles starting a recording
class StartRecordingUseCase {
  final RecordingRepository _repository;
  final Uuid _uuid;
  
  StartRecordingUseCase({
    required RecordingRepository repository,
  })  : _repository = repository,
        _uuid = const Uuid();
  
  Future<Result<Recording>> call(StartRecordingParams params) async {
    try {
      // Check if there's already an active recording
      final activeResult = await _repository.getActiveRecording();
      if (activeResult.isFailure) {
        return Result.failure(activeResult.failureOrNull!);
      }
      
      if (activeResult.dataOrNull != null) {
        return Result.failure(
          const ValidationFailure(
            message: 'Cannot start recording: another recording is already active. Please pause it first.',
          ),
        );
      }
      
      // Create recording
      final createResult = await _repository.createRecording(
        CreateRecordingParams(
          title: params.title,
          mode: params.mode,
          clientCode: params.clientCode,
        ),
      );
      
      if (createResult.isFailure) {
        return Result.failure(createResult.failureOrNull!);
      }
      
      final recording = createResult.dataOrNull!;
      
      // Create initial segment
      final segmentResult = await _repository.addSegment(
        recordingId: recording.id,
        index: 0,
        startedAt: DateTime.now(),
      );
      
      if (segmentResult.isFailure) {
        return Result.failure(segmentResult.failureOrNull!);
      }
      
      // Update status to recording
      final updateResult = await _repository.updateRecordingStatus(
        UpdateRecordingStatusParams(
          recordingId: recording.id,
          status: RecordingStatus.recording,
        ),
      );
      
      if (updateResult.isFailure) {
        return Result.failure(updateResult.failureOrNull!);
      }
      
      return Result.success(updateResult.dataOrNull!);
    } catch (e) {
      return Result.failure(
        UnknownFailure(
          message: 'Failed to start recording',
          originalError: e,
        ),
      );
    }
  }
}
