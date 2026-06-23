import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:scribble/app/core/error/failures.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/domain/interfaces/v2_boundaries.dart';
import 'package:scribble/app/domain/repositories/chunk_repository.dart';

import '../core/constants/app_constants.dart';

/// Audio Service - manages recording and playback
class AudioService extends GetxService {
  final _audioRecorder = AudioRecorder();
  final _audioPlayer = AudioPlayer();
  AudioSession? _audioSession;

  StreamSubscription<RecordState>? _recordStateSubscription;
  final _isRecording = false.obs;
  final _recordingDuration = Duration.zero.obs;
  Timer? _durationTimer;

  bool get isRecording => _isRecording.value;
  Duration get recordingDuration => _recordingDuration.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initAudioSession();
  }

  Future<void> _initAudioSession() async {
    _audioSession = await AudioSession.instance;
    await _audioSession!.configure(const AudioSessionConfiguration.speech());
  }

  /// Start recording to file
  Future<Result<void>> startRecording(String filePath) async {
    try {
      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: filePath,
      );

      _isRecording.value = true;
      _startDurationTimer();

      return Result.success(null);
    } catch (e) {
      return Result.failure(AudioFailure(
        message: 'Failed to start recording',
        originalError: e,
      ));
    }
  }

  /// Pause recording
  Future<Result<void>> pauseRecording() async {
    try {
      await _audioRecorder.pause();
      _isRecording.value = false;
      _stopDurationTimer();
      return Result.success(null);
    } catch (e) {
      return Result.failure(AudioFailure(
        message: 'Failed to pause recording',
        originalError: e,
      ));
    }
  }

  /// Resume recording
  Future<Result<void>> resumeRecording() async {
    try {
      await _audioRecorder.resume();
      _isRecording.value = true;
      _startDurationTimer();
      return Result.success(null);
    } catch (e) {
      return Result.failure(AudioFailure(
        message: 'Failed to resume recording',
        originalError: e,
      ));
    }
  }

  /// Stop recording
  Future<Result<String?>> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      _isRecording.value = false;
      _stopDurationTimer();
      _recordingDuration.value = Duration.zero;
      return Result.success(path);
    } catch (e) {
      return Result.failure(AudioFailure(
        message: 'Failed to stop recording',
        originalError: e,
      ));
    }
  }

  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recordingDuration.value += const Duration(seconds: 1);
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
  }

  /// Play audio file
  Future<Result<void>> play(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
      return Result.success(null);
    } catch (e) {
      return Result.failure(AudioFailure(
        message: 'Failed to play audio',
        originalError: e,
      ));
    }
  }

  /// Pause playback
  Future<Result<void>> pausePlayback() async {
    try {
      await _audioPlayer.pause();
      return Result.success(null);
    } catch (e) {
      return Result.failure(AudioFailure(
        message: 'Failed to pause playback',
        originalError: e,
      ));
    }
  }

  @override
  void onClose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _recordStateSubscription?.cancel();
    _durationTimer?.cancel();
    super.onClose();
  }
}

/// Crypto Service - handles encryption/decryption in isolates
class CryptoService extends GetxService {
  final KeyProvider _keyProvider;

  CryptoService({required KeyProvider keyProvider}) : _keyProvider = keyProvider;

  /// Encrypt file (in isolate for v1, will use isolate_manager)
  Future<Result<String>> encryptFile({
    required String inputPath,
    required String outputPath,
  }) async {
    try {
      // V1: Simplified encryption simulation
      // V2: Use isolate_manager + existing production crypto impl
      final inputFile = File(inputPath);
      final outputFile = File(outputPath);

      if (!await inputFile.exists()) {
        return Result.failure(
          const FileSystemFailure(message: 'Input file not found'),
        );
      }

      // Simulate encryption by copying file with .xsba extension
      // Real crypto will be implemented here
      await inputFile.copy(outputFile.path);

      return Result.success(outputFile.path);
    } catch (e) {
      return Result.failure(CryptoFailure(
        message: 'Encryption failed',
        originalError: e,
      ));
    }
  }

  /// Decrypt file (in isolate)
  Future<Result<String>> decryptFile({
    required String inputPath,
    required String outputPath,
  }) async {
    try {
      // V1: Simplified decryption simulation
      final inputFile = File(inputPath);
      final outputFile = File(outputPath);

      if (!await inputFile.exists()) {
        return Result.failure(
          const FileSystemFailure(message: 'Input file not found'),
        );
      }

      // Simulate decryption by copying file
      await inputFile.copy(outputFile.path);

      return Result.success(outputFile.path);
    } catch (e) {
      return Result.failure(CryptoFailure(
        message: 'Decryption failed',
        originalError: e,
      ));
    }
  }

  /// Compute SHA-256 hash (in isolate)
  Future<Result<String>> computeHash(String filePath) async {
    try {
      // V1: Simplified hash
      // V2: Real SHA-256 using crypto package in isolate
      final file = File(filePath);
      final size = await file.length();
      return Result.success('sha256_${size}_mock');
    } catch (e) {
      return Result.failure(CryptoFailure(
        message: 'Hash computation failed',
        originalError: e,
      ));
    }
  }
}

/// Queue Service - processes upload queue with sequential ordering
class QueueService extends GetxService {
  final ChunkRepository _chunkRepository;
  final UploadSink _uploadSink;
  final _isProcessing = false.obs;

  QueueService({
    required ChunkRepository chunkRepository,
    required UploadSink uploadSink,
  })  : _chunkRepository = chunkRepository,
        _uploadSink = uploadSink;

  bool get isProcessing => _isProcessing.value;

  /// Process pending chunks in queue (sequential by sequence)
  Future<void> processQueue() async {
    if (_isProcessing.value) return;

    _isProcessing.value = true;

    try {
      final readyResult = await _chunkRepository.getReadyChunks();

      if (readyResult.isSuccess) {
        final chunks = readyResult.dataOrNull!;

        // CRITICAL: Sort by sequence to maintain order
        chunks.sort((a, b) => a.sequence.compareTo(b.sequence));

        // Upload sequentially (not in parallel) to guarantee order
        for (final chunk in chunks) {
          if (chunk.encryptedFilePath == null || chunk.hash == null) continue;

          // Update to uploading
          await _chunkRepository.updateChunkStatus(
            UpdateChunkStatusParams(
              chunkId: chunk.id,
              status: ChunkStatus.uploading,
            ),
          );

          // Upload via sink with sequence number
          final uploadResult = await _uploadSink.uploadChunk(
            chunkId: chunk.id,
            recordingId: chunk.recordingId,
            sequence: chunk.sequence, // CRITICAL: Send sequence
            filePath: chunk.encryptedFilePath!,
            hash: chunk.hash!,
          );

          if (uploadResult.isSuccess) {
            await _chunkRepository.updateChunkStatus(
              UpdateChunkStatusParams(
                chunkId: chunk.id,
                status: ChunkStatus.uploaded,
              ),
            );
          } else {
            // Increment retry count
            final current = await _chunkRepository.getChunk(chunk.id);
            if (current.isSuccess) {
              final currentChunk = current.dataOrNull!;

              if (currentChunk.canRetry(AppConstants.maxRetryCount)) {
                await _chunkRepository.incrementRetryCount(chunk.id);
                await _chunkRepository.updateChunkStatus(
                  UpdateChunkStatusParams(
                    chunkId: chunk.id,
                    status: ChunkStatus.failed,
                  ),
                );
              } else {
                // Exceeded max retries - mark as dead
                await _chunkRepository.markChunkAsDead(chunk.id);
              }
            }
          }
        }
      }
    } finally {
      _isProcessing.value = false;
    }
  }

  /// Start queue processing loop
  void startProcessing() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      processQueue();
    });
  }
}
