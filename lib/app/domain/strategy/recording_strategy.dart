import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/domain/entities/recording.dart';

/// Strategy interface for recording modes (Open/Closed Principle)
abstract class RecordingStrategy {
  /// Start recording
  Future<Result<void>> start(Recording recording);
  
  /// Process captured audio data
  Future<Result<void>> processAudioData(
    Recording recording,
    List<int> audioData,
  );
  
  /// Pause recording
  Future<Result<void>> pause(Recording recording);
  
  /// Resume recording
  Future<Result<void>> resume(Recording recording);
  
  /// Stop recording and finalize
  Future<Result<void>> stop(Recording recording);
}

/// Live-Chunk strategy implementation
/// Record → chunk (cipher-aligned) → encrypt (isolate) → hash → enqueue
class LiveChunkStrategy implements RecordingStrategy {
  // Will be injected via constructor
  final dynamic _chunkRepository;
  final dynamic _cryptoService;
  final dynamic _queueService;
  
  LiveChunkStrategy({
    required dynamic chunkRepository,
    required dynamic cryptoService,
    required dynamic queueService,
  })  : _chunkRepository = chunkRepository,
        _cryptoService = cryptoService,
        _queueService = queueService;
  
  @override
  Future<Result<void>> start(Recording recording) async {
    // Initialize streaming encryption
    // Create initial chunk records
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> processAudioData(
    Recording recording,
    List<int> audioData,
  ) async {
    // Chunk the data (cipher-aligned)
    // Encrypt each chunk in isolate
    // Compute hash
    // Update chunk status: pending → encrypting → ready
    // Enqueue for upload
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> pause(Recording recording) async {
    // Paused chunked sessions continue processing already-captured chunks
    // Just mark the recording as paused in DB
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> resume(Recording recording) async {
    // Resume audio capture
    // Continue chunking pipeline
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> stop(Recording recording) async {
    // Wait for all pending chunks to complete encryption
    // Mark recording as done
    return Result.success(null);
  }
}

/// Record-Full-Then-Upload strategy implementation
/// Record (full session) → stitch → encode mp3 → encrypt → hash → enqueue
class RecordFullStrategy implements RecordingStrategy {
  // Will be injected via constructor
  final dynamic _recordingRepository;
  final dynamic _cryptoService;
  final dynamic _chunkRepository;
  
  RecordFullStrategy({
    required dynamic recordingRepository,
    required dynamic cryptoService,
    required dynamic chunkRepository,
  })  : _recordingRepository = recordingRepository,
        _cryptoService = cryptoService,
        _chunkRepository = chunkRepository;
  
  @override
  Future<Result<void>> start(Recording recording) async {
    // Start capturing to temp file
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> processAudioData(
    Recording recording,
    List<int> audioData,
  ) async {
    // Write to temp file (plaintext while recording)
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> pause(Recording recording) async {
    // Paused full-mode sessions sit idle - no processing
    // Just mark segment as paused
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> resume(Recording recording) async {
    // Create new segment
    // Continue writing to file
    return Result.success(null);
  }
  
  @override
  Future<Result<void>> stop(Recording recording) async {
    // Stitch all segment files
    // Encode to mp3
    // Encrypt entire file in isolate
    // Compute hash
    // Create chunk record
    // Enqueue for upload
    // Delete plaintext temp files
    return Result.success(null);
  }
}
