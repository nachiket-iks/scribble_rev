import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/mixins/controller_mixins.dart';
import 'package:scribble/app/domain/entities/recording.dart';
import 'package:scribble/app/domain/repositories/recording_repository.dart';
import 'package:scribble/app/domain/usecases/start_recording.dart';
import 'package:scribble/app/domain/usecases/recording_usecases.dart';
import 'package:scribble/app/services/app_services.dart';

/// Controller for recording screen
class RecordingController extends GetxController 
    with DisposableMixin, LoggerMixin, ReactiveStateMixin {
  // Dependencies
  final RecordingRepository _recordingRepository;
  final AudioService _audioService;
  final StartRecordingUseCase _startRecording;
  final PauseRecordingUseCase _pauseRecording;
  final ResumeRecordingUseCase _resumeRecording;
  final StopRecordingUseCase _stopRecording;
  
  // State
  final Rx<Recording?> currentRecording = Rx<Recording?>(null);
  final RxList<Recording> pausedRecordings = <Recording>[].obs;
  
  RecordingController({
    required RecordingRepository recordingRepository,
    required AudioService audioService,
    required StartRecordingUseCase startRecording,
    required PauseRecordingUseCase pauseRecording,
    required ResumeRecordingUseCase resumeRecording,
    required StopRecordingUseCase stopRecording,
  })  : _recordingRepository = recordingRepository,
        _audioService = audioService,
        _startRecording = startRecording,
        _pauseRecording = pauseRecording,
        _resumeRecording = resumeRecording,
        _stopRecording = stopRecording;
  
  @override
  void onInit() {
    super.onInit();
    _loadPausedRecordings();
  }
  
  Future<void> _loadPausedRecordings() async {
    final result = await _recordingRepository.getPausedRecordings();
    if (result.isSuccess) {
      pausedRecordings.value = result.dataOrNull!;
    }
  }
  
  /// Start a new recording
  Future<void> startRecording({
    required String title,
    required RecordingMode mode,
    required String clientCode,
  }) async {
    await executeAsync(
      () async {
        // Check if there's an active recording
        final activeResult = await _recordingRepository.getActiveRecording();
        if (activeResult.isSuccess && activeResult.dataOrNull != null) {
          Get.snackbar(
            'Cannot Start',
            'Please pause the active recording first',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        
        // Start recording use case
        final result = await _startRecording(
          StartRecordingParams(
            title: title,
            mode: mode,
            clientCode: clientCode,
          ),
        );
        
        if (result.isSuccess) {
          final recording = result.dataOrNull!;
          currentRecording.value = recording;
          
          // Start audio recording
          final tempDir = await getTemporaryDirectory();
          final filePath = '${tempDir.path}/${recording.id}_segment_0.m4a';
          
          await _audioService.startRecording(filePath);
          
          logInfo('Started recording: ${recording.id}');
        } else {
          Get.snackbar(
            'Error',
            result.failureOrNull?.message ?? 'Failed to start recording',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      errorMessage: 'Failed to start recording',
    );
  }
  
  /// Pause current recording
  Future<void> pauseRecording() async {
    final recording = currentRecording.value;
    if (recording == null) return;
    
    await executeAsync(
      () async {
        // Pause audio
        await _audioService.pauseRecording();
        
        // Pause recording use case
        final result = await _pauseRecording(recording.id);
        
        if (result.isSuccess) {
          currentRecording.value = null;
          await _loadPausedRecordings();
          logInfo('Paused recording: ${recording.id}');
        }
      },
      errorMessage: 'Failed to pause recording',
    );
  }
  
  /// Resume a paused recording
  Future<void> resumeRecording(Recording recording) async {
    await executeAsync(
      () async {
        // Check if there's an active recording
        final activeResult = await _recordingRepository.getActiveRecording();
        if (activeResult.isSuccess && activeResult.dataOrNull != null) {
          Get.snackbar(
            'Cannot Resume',
            'Please pause the active recording first',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
        
        // Resume recording use case
        final result = await _resumeRecording(recording.id);
        
        if (result.isSuccess) {
          currentRecording.value = result.dataOrNull!;
          
          // Resume audio
          await _audioService.resumeRecording();
          
          await _loadPausedRecordings();
          logInfo('Resumed recording: ${recording.id}');
        }
      },
      errorMessage: 'Failed to resume recording',
    );
  }
  
  /// Stop current recording
  Future<void> stopRecording() async {
    final recording = currentRecording.value;
    if (recording == null) return;
    
    await executeAsync(
      () async {
        // Stop audio
        final audioResult = await _audioService.stopRecording();
        
        if (audioResult.isSuccess) {
          // Stop recording use case
          final result = await _stopRecording(recording.id);
          
          if (result.isSuccess) {
            currentRecording.value = null;
            
            Get.snackbar(
              'Recording Stopped',
              'Processing and encryption in progress',
              snackPosition: SnackPosition.BOTTOM,
            );
            
            logInfo('Stopped recording: ${recording.id}');
            
            // Navigate back to home
            Get.back();
          }
        }
      },
      errorMessage: 'Failed to stop recording',
    );
  }
}
