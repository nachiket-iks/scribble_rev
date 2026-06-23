import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:scribble/app/core/constants/app_constants.dart';

import '../../domain/entities/recording.dart';

part 'database.g.dart';

/// Recordings table
class Recordings extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get mode => text()(); // 'liveChunk' | 'recordFull'
  TextColumn get status => text()(); // enum as string
  TextColumn get clientCode => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get totalDurationMs => integer().withDefault(const Constant(0))();
  IntColumn get totalParts => integer().withDefault(const Constant(0))();
  TextColumn get computedHashKey => text().nullable()();
  TextColumn get metadataJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Segments table
class Segments extends Table {
  TextColumn get id => text()();
  TextColumn get recordingId => text().references(Recordings, #id, onDelete: KeyAction.cascade)();
  IntColumn get index => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get pausedAt => dateTime().nullable()();
  DateTimeColumn get resumedAt => dateTime().nullable()();
  DateTimeColumn get stoppedAt => dateTime().nullable()();
  TextColumn get filePath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// UploadChunks table - Aggregated chunks for network upload
/// Two-level chunking: cipher chunks (8KB) → upload chunks (5-10MB)
class UploadChunks extends Table {
  TextColumn get id => text()();
  TextColumn get recordingId => text().references(Recordings, #id, onDelete: KeyAction.cascade)();
  TextColumn get segmentId => text().nullable().references(Segments, #id, onDelete: KeyAction.cascade)();
  IntColumn get sequence => integer()(); // Upload sequence number (0, 1, 2...)
  IntColumn get startCipherIndex => integer()(); // First cipher chunk in this upload
  IntColumn get endCipherIndex => integer()(); // Last cipher chunk in this upload
  TextColumn get status => text()(); // enum as string
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get encryptedFilePath => text().nullable()();
  IntColumn get sizeBytes => integer()(); // Actual file size
  TextColumn get hash => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {recordingId, sequence}, // Ensure sequence integrity per recording
      ];
}

/// Upload Jobs table
class UploadJobs extends Table {
  TextColumn get id => text()();
  TextColumn get recordingId => text().references(Recordings, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => text()(); // enum as string
  IntColumn get totalChunks => integer()();
  IntColumn get uploadedChunks => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Main database class
@DriftDatabase(tables: [Recordings, Segments, UploadChunks, UploadJobs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations will go here
      },
    );
  }

  // Recording queries
  Future<Recording> insertRecording(RecordingsCompanion recording) {
    return into(recordings).insertReturning(recording);
  }

  Future<Recording?> getRecordingById(String id) {
    return (select(recordings)..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  Future<List<Recording>> getAllRecordings() {
    return (select(recordings)..orderBy([(r) => OrderingTerm.desc(r.createdAt)])).get();
  }

  Stream<List<Recording>> watchAllRecordings() {
    return (select(recordings)..orderBy([(r) => OrderingTerm.desc(r.createdAt)])).watch();
  }

  Stream<Recording> watchRecording(String id) {
    return (select(recordings)..where((r) => r.id.equals(id))).watchSingle();
  }

  Future<Recording?> getActiveRecording() {
    return (select(recordings)..where((r) => r.status.equals(RecordingStatus.recording.name))).getSingleOrNull();
  }

  Future<List<Recording>> getPausedRecordings() {
    return (select(recordings)..where((r) => r.status.equals(RecordingStatus.paused.name))).get();
  }

  Future<int> updateRecording(RecordingsCompanion recording) {
    return (update(recordings)..where((r) => r.id.equals(recording.id.value))).write(recording);
  }

  Future<int> deleteRecording(String id) {
    return (delete(recordings)..where((r) => r.id.equals(id))).go();
  }

  // Segment queries
  Future<Segment> insertSegment(SegmentsCompanion segment) {
    return into(segments).insertReturning(segment);
  }

  Future<Segment?> getSegmentById(String id) {
    return (select(segments)..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  Future<List<Segment>> getSegmentsForRecording(String recordingId) {
    return (select(segments)
          ..where((s) => s.recordingId.equals(recordingId))
          ..orderBy([(s) => OrderingTerm.asc(s.index)]))
        .get();
  }

  Future<int> updateSegment(SegmentsCompanion segment) {
    return (update(segments)..where((s) => s.id.equals(segment.id.value))).write(segment);
  }

  // Upload chunk queries
  Future<UploadChunk> insertUploadChunk(UploadChunksCompanion chunk) {
    return into(uploadChunks).insertReturning(chunk);
  }

  Future<UploadChunk?> getUploadChunkById(String id) {
    return (select(uploadChunks)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<List<UploadChunk>> getUploadChunksForRecording(String recordingId) {
    return (select(uploadChunks)
          ..where((c) => c.recordingId.equals(recordingId))
          ..orderBy([(c) => OrderingTerm.asc(c.sequence)]) // Order by sequence
        )
        .get();
  }

  Stream<List<UploadChunk>> watchUploadChunksForRecording(String recordingId) {
    return (select(uploadChunks)
          ..where((c) => c.recordingId.equals(recordingId))
          ..orderBy([(c) => OrderingTerm.asc(c.sequence)]))
        .watch();
  }

  Stream<UploadChunk> watchUploadChunk(String id) {
    return (select(uploadChunks)..where((c) => c.id.equals(id))).watchSingle();
  }

  Future<List<UploadChunk>> getUploadChunksByStatus(ChunkStatus status) {
    return (select(uploadChunks)
          ..where((c) => c.status.equals(status.name))
          ..orderBy([(c) => OrderingTerm.asc(c.sequence)]))
        .get();
  }

  Future<int> updateUploadChunk(UploadChunksCompanion chunk) {
    return (update(uploadChunks)..where((c) => c.id.equals(chunk.id.value))).write(chunk);
  }

  Future<int> deleteUploadChunksForRecording(String recordingId) {
    return (delete(uploadChunks)..where((c) => c.recordingId.equals(recordingId))).go();
  }

  // Upload job queries
  Future<UploadJob> insertUploadJob(UploadJobsCompanion job) {
    return into(uploadJobs).insertReturning(job);
  }

  Future<UploadJob?> getUploadJobById(String id) {
    return (select(uploadJobs)..where((j) => j.id.equals(id))).getSingleOrNull();
  }

  Future<UploadJob?> getUploadJobForRecording(String recordingId) {
    return (select(uploadJobs)..where((j) => j.recordingId.equals(recordingId))).getSingleOrNull();
  }

  Future<List<UploadJob>> getAllUploadJobs() {
    return select(uploadJobs).get();
  }

  Stream<UploadJob> watchUploadJob(String id) {
    return (select(uploadJobs)..where((j) => j.id.equals(id))).watchSingle();
  }

  Stream<List<UploadJob>> watchAllUploadJobs() {
    return select(uploadJobs).watch();
  }

  Future<int> updateUploadJob(UploadJobsCompanion job) {
    return (update(uploadJobs)..where((j) => j.id.equals(job.id.value))).write(job);
  }

  Future<int> deleteUploadJob(String id) {
    return (delete(uploadJobs)..where((j) => j.id.equals(id))).go();
  }
}

/// Open database connection
QueryExecutor _openConnection() {
  return driftDatabase(name: AppConstants.databaseName);
}
