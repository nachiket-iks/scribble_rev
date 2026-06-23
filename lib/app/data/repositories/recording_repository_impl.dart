import 'package:drift/drift.dart';
import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/core/error/failures.dart';
import 'package:scribble/app/domain/entities/recording.dart' as domain;
import 'package:scribble/app/domain/entities/segment.dart' as domain;
import 'package:scribble/app/domain/repositories/recording_repository.dart';
import 'package:scribble/app/data/database/database.dart';
import 'package:uuid/uuid.dart';

/// Implementation of RecordingRepository using Drift
class RecordingRepositoryImpl implements RecordingRepository {
  final AppDatabase _database;
  final Uuid _uuid;
  
  RecordingRepositoryImpl({
    required AppDatabase database,
  })  : _database = database,
        _uuid = const Uuid();
  
  @override
  Future<Result<domain.Recording>> createRecording(
    CreateRecordingParams params,
  ) async {
    try {
      final now = DateTime.now();
      final recording = await _database.insertRecording(
        RecordingsCompanion.insert(
          id: _uuid.v4(),
          title: params.title,
          mode: params.mode.name,
          status: RecordingStatus.idle.name,
          clientCode: params.clientCode,
          createdAt: now,
          updatedAt: now,
        ),
      );
      
      return Result.success(_mapRecordingToDomain(recording));
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to create recording',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<domain.Recording>> getRecording(String id) async {
    try {
      final recording = await _database.getRecordingById(id);
      
      if (recording == null) {
        return Result.failure(
          const DatabaseFailure(message: 'Recording not found'),
        );
      }
      
      return Result.success(_mapRecordingToDomain(recording));
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to get recording',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<domain.Recording>> updateRecordingStatus(
    UpdateRecordingStatusParams params,
  ) async {
    try {
      await _database.updateRecording(
        RecordingsCompanion(
          id: Value(params.recordingId),
          status: Value(params.status.name),
          updatedAt: Value(DateTime.now()),
          totalDurationMs: params.totalDurationMs != null
              ? Value(params.totalDurationMs!)
              : const Value.absent(),
          totalParts: params.totalParts != null
              ? Value(params.totalParts!)
              : const Value.absent(),
          computedHashKey: params.computedHashKey != null
              ? Value(params.computedHashKey!)
              : const Value.absent(),
          metadataJson: params.metadataJson != null
              ? Value(params.metadataJson!)
              : const Value.absent(),
        ),
      );
      
      final recording = await _database.getRecordingById(params.recordingId);
      return Result.success(_mapRecordingToDomain(recording!));
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to update recording status',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<domain.Segment>> addSegment({
    required String recordingId,
    required int index,
    required DateTime startedAt,
  }) async {
    try {
      final segment = await _database.insertSegment(
        SegmentsCompanion.insert(
          id: _uuid.v4(),
          recordingId: recordingId,
          index: index,
          startedAt: startedAt,
        ),
      );
      
      return Result.success(_mapSegmentToDomain(segment));
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to add segment',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<domain.Segment>> updateSegment({
    required String segmentId,
    DateTime? pausedAt,
    DateTime? resumedAt,
    DateTime? stoppedAt,
    String? filePath,
  }) async {
    try {
      await _database.updateSegment(
        SegmentsCompanion(
          id: Value(segmentId),
          pausedAt: pausedAt != null ? Value(pausedAt) : const Value.absent(),
          resumedAt: resumedAt != null ? Value(resumedAt) : const Value.absent(),
          stoppedAt: stoppedAt != null ? Value(stoppedAt) : const Value.absent(),
          filePath: filePath != null ? Value(filePath) : const Value.absent(),
        ),
      );
      
      final segment = await _database.getSegmentById(segmentId);
      return Result.success(_mapSegmentToDomain(segment!));
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to update segment',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<List<domain.Segment>>> getSegments(String recordingId) async {
    try {
      final segments = await _database.getSegmentsForRecording(recordingId);
      return Result.success(segments.map(_mapSegmentToDomain).toList());
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to get segments',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<List<domain.Recording>>> getAllRecordings() async {
    try {
      final recordings = await _database.getAllRecordings();
      return Result.success(recordings.map(_mapRecordingToDomain).toList());
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to get all recordings',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Stream<List<domain.Recording>> watchAllRecordings() {
    return _database.watchAllRecordings().map(
      (recordings) => recordings.map(_mapRecordingToDomain).toList(),
    );
  }
  
  @override
  Stream<domain.Recording> watchRecording(String id) {
    return _database.watchRecording(id).map(_mapRecordingToDomain);
  }
  
  @override
  Future<Result<domain.Recording?>> getActiveRecording() async {
    try {
      final recording = await _database.getActiveRecording();
      return Result.success(
        recording != null ? _mapRecordingToDomain(recording) : null,
      );
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to get active recording',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<List<domain.Recording>>> getPausedRecordings() async {
    try {
      final recordings = await _database.getPausedRecordings();
      return Result.success(recordings.map(_mapRecordingToDomain).toList());
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to get paused recordings',
          originalError: e,
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> deleteRecording(String id) async {
    try {
      await _database.deleteRecording(id);
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        DatabaseFailure(
          message: 'Failed to delete recording',
          originalError: e,
        ),
      );
    }
  }
  
  // Mappers
  domain.Recording _mapRecordingToDomain(Recording recording) {
    return domain.Recording(
      id: recording.id,
      title: recording.title,
      mode: _parseRecordingMode(recording.mode),
      status: _parseRecordingStatus(recording.status),
      clientCode: recording.clientCode,
      createdAt: recording.createdAt,
      updatedAt: recording.updatedAt,
      totalDurationMs: recording.totalDurationMs,
      totalParts: recording.totalParts,
      computedHashKey: recording.computedHashKey,
      metadataJson: recording.metadataJson,
    );
  }
  
  domain.Segment _mapSegmentToDomain(Segment segment) {
    return domain.Segment(
      id: segment.id,
      recordingId: segment.recordingId,
      index: segment.index,
      startedAt: segment.startedAt,
      pausedAt: segment.pausedAt,
      resumedAt: segment.resumedAt,
      stoppedAt: segment.stoppedAt,
      filePath: segment.filePath,
    );
  }
  
  RecordingMode _parseRecordingMode(String mode) {
    return RecordingMode.values.firstWhere(
      (m) => m.name == mode,
      orElse: () => RecordingMode.recordFull,
    );
  }
  
  RecordingStatus _parseRecordingStatus(String status) {
    return RecordingStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => RecordingStatus.idle,
    );
  }
}
