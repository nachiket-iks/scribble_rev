import 'package:drift/drift.dart';
import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/core/error/failures.dart';
import 'package:scribble/app/domain/entities/chunk.dart' as domain;
import 'package:scribble/app/domain/entities/upload_job.dart' as domain;
import 'package:scribble/app/domain/repositories/chunk_repository.dart';
import 'package:scribble/app/domain/repositories/queue_repository.dart';
import 'package:scribble/app/data/database/database.dart';
import 'package:uuid/uuid.dart';

/// Implementation of ChunkRepository using Drift
class ChunkRepositoryImpl implements ChunkRepository {
  final AppDatabase _database;
  final Uuid _uuid;
  
  ChunkRepositoryImpl({required AppDatabase database})
      : _database = database,
        _uuid = const Uuid();
  
  @override
  Future<Result<domain.UploadChunk>> createChunk(CreateUploadChunkParams params) async {
    try {
      final now = DateTime.now();
      final chunk = await _database.insertUploadChunk(
        UploadChunksCompanion.insert(
          id: _uuid.v4(),
          recordingId: params.recordingId,
          segmentId: Value(params.segmentId),
          sequence: params.sequence,
          startCipherIndex: params.startCipherIndex,
          endCipherIndex: params.endCipherIndex,
          status: ChunkStatus.pending.name,
          sizeBytes: params.sizeBytes,
          createdAt: now,
          updatedAt: now,
        ),
      );
      
      return Result.success(_mapToDomain(chunk));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to create upload chunk',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadChunk>> getChunk(String id) async {
    try {
      final chunk = await _database.getUploadChunkById(id);
      if (chunk == null) {
        return Result.failure(const DatabaseFailure(message: 'Upload chunk not found'));
      }
      return Result.success(_mapToDomain(chunk));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get upload chunk',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadChunk>> updateChunkStatus(UpdateChunkStatusParams params) async {
    try {
      await _database.updateUploadChunk(
        UploadChunksCompanion(
          id: Value(params.chunkId),
          status: Value(params.status.name),
          updatedAt: Value(DateTime.now()),
          encryptedFilePath: params.encryptedFilePath != null
              ? Value(params.encryptedFilePath!)
              : const Value.absent(),
          hash: params.hash != null ? Value(params.hash!) : const Value.absent(),
          retryCount: params.retryCount != null
              ? Value(params.retryCount!)
              : const Value.absent(),
        ),
      );
      
      final chunk = await _database.getUploadChunkById(params.chunkId);
      return Result.success(_mapToDomain(chunk!));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to update upload chunk status',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<List<domain.UploadChunk>>> getChunksForRecording(String recordingId) async {
    try {
      final chunks = await _database.getUploadChunksForRecording(recordingId);
      return Result.success(chunks.map(_mapToDomain).toList());
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get upload chunks',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<List<domain.UploadChunk>>> getChunksByStatus(ChunkStatus status) async {
    try {
      final chunks = await _database.getUploadChunksByStatus(status);
      return Result.success(chunks.map(_mapToDomain).toList());
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get upload chunks by status',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<List<domain.UploadChunk>>> getPendingChunks() =>
      getChunksByStatus(ChunkStatus.pending);
  
  @override
  Future<Result<List<domain.UploadChunk>>> getReadyChunks() =>
      getChunksByStatus(ChunkStatus.ready);
  
  @override
  Stream<List<domain.UploadChunk>> watchChunksForRecording(String recordingId) {
    return _database.watchUploadChunksForRecording(recordingId)
        .map((chunks) => chunks.map(_mapToDomain).toList());
  }
  
  @override
  Stream<domain.UploadChunk> watchChunk(String id) {
    return _database.watchUploadChunk(id).map(_mapToDomain);
  }
  
  @override
  Future<Result<void>> deleteChunksForRecording(String recordingId) async {
    try {
      await _database.deleteUploadChunksForRecording(recordingId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to delete upload chunks',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadChunk>> incrementRetryCount(String chunkId) async {
    try {
      final chunk = await _database.getUploadChunkById(chunkId);
      if (chunk == null) {
        return Result.failure(const DatabaseFailure(message: 'Upload chunk not found'));
      }
      
      await _database.updateUploadChunk(
        UploadChunksCompanion(
          id: Value(chunkId),
          retryCount: Value(chunk.retryCount + 1),
          updatedAt: Value(DateTime.now()),
        ),
      );
      
      final updated = await _database.getUploadChunkById(chunkId);
      return Result.success(_mapToDomain(updated!));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to increment retry count',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadChunk>> markChunkAsDead(String chunkId) async {
    return updateChunkStatus(UpdateChunkStatusParams(
      chunkId: chunkId,
      status: ChunkStatus.dead,
    ));
  }
  
  domain.UploadChunk _mapToDomain(UploadChunk chunk) {
    return domain.UploadChunk(
      id: chunk.id,
      recordingId: chunk.recordingId,
      segmentId: chunk.segmentId,
      sequence: chunk.sequence,
      startCipherIndex: chunk.startCipherIndex,
      endCipherIndex: chunk.endCipherIndex,
      status: ChunkStatus.values.firstWhere((s) => s.name == chunk.status),
      retryCount: chunk.retryCount,
      encryptedFilePath: chunk.encryptedFilePath,
      sizeBytes: chunk.sizeBytes,
      hash: chunk.hash,
      createdAt: chunk.createdAt,
      updatedAt: chunk.updatedAt,
    );
  }
}

/// Implementation of QueueRepository using Drift
class QueueRepositoryImpl implements QueueRepository {
  final AppDatabase _database;
  final Uuid _uuid;
  
  QueueRepositoryImpl({required AppDatabase database})
      : _database = database,
        _uuid = const Uuid();
  
  @override
  Future<Result<domain.UploadJob>> createUploadJob(CreateUploadJobParams params) async {
    try {
      final job = await _database.insertUploadJob(
        UploadJobsCompanion.insert(
          id: _uuid.v4(),
          recordingId: params.recordingId,
          status: UploadJobStatus.pending.name,
          totalChunks: params.totalChunks,
          createdAt: DateTime.now(),
        ),
      );
      
      return Result.success(_mapToDomain(job));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to create upload job',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadJob>> getUploadJob(String id) async {
    try {
      final job = await _database.getUploadJobById(id);
      if (job == null) {
        return Result.failure(const DatabaseFailure(message: 'Upload job not found'));
      }
      return Result.success(_mapToDomain(job));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get upload job',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadJob?>> getUploadJobForRecording(String recordingId) async {
    try {
      final job = await _database.getUploadJobForRecording(recordingId);
      return Result.success(job != null ? _mapToDomain(job) : null);
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get upload job for recording',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadJob>> updateUploadJob(UpdateUploadJobParams params) async {
    try {
      await _database.updateUploadJob(
        UploadJobsCompanion(
          id: Value(params.jobId),
          status: params.status != null ? Value(params.status!.name) : const Value.absent(),
          uploadedChunks: params.uploadedChunks != null
              ? Value(params.uploadedChunks!)
              : const Value.absent(),
          lastAttemptAt: params.lastAttemptAt != null
              ? Value(params.lastAttemptAt!)
              : const Value.absent(),
        ),
      );
      
      final job = await _database.getUploadJobById(params.jobId);
      return Result.success(_mapToDomain(job!));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to update upload job',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<domain.UploadJob>> incrementUploadedChunks(String jobId) async {
    try {
      final job = await _database.getUploadJobById(jobId);
      if (job == null) {
        return Result.failure(const DatabaseFailure(message: 'Upload job not found'));
      }
      
      await _database.updateUploadJob(
        UploadJobsCompanion(
          id: Value(jobId),
          uploadedChunks: Value(job.uploadedChunks + 1),
        ),
      );
      
      final updated = await _database.getUploadJobById(jobId);
      return Result.success(_mapToDomain(updated!));
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to increment uploaded chunks',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<List<domain.UploadJob>>> getPendingJobs() async {
    try {
      final jobs = await _database.getAllUploadJobs();
      final pending = jobs.where((j) => j.status == UploadJobStatus.pending.name).toList();
      return Result.success(pending.map(_mapToDomain).toList());
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get pending jobs',
        originalError: e,
      ));
    }
  }
  
  @override
  Future<Result<List<domain.UploadJob>>> getActiveJobs() async {
    try {
      final jobs = await _database.getAllUploadJobs();
      final active = jobs.where((j) => j.status == UploadJobStatus.running.name).toList();
      return Result.success(active.map(_mapToDomain).toList());
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to get active jobs',
        originalError: e,
      ));
    }
  }
  
  @override
  Stream<domain.UploadJob> watchUploadJob(String id) {
    return _database.watchUploadJob(id).map(_mapToDomain);
  }
  
  @override
  Stream<List<domain.UploadJob>> watchAllUploadJobs() {
    return _database.watchAllUploadJobs()
        .map((jobs) => jobs.map(_mapToDomain).toList());
  }
  
  @override
  Future<Result<void>> deleteUploadJob(String id) async {
    try {
      await _database.deleteUploadJob(id);
      return Result.success(null);
    } catch (e) {
      return Result.failure(DatabaseFailure(
        message: 'Failed to delete upload job',
        originalError: e,
      ));
    }
  }
  
  domain.UploadJob _mapToDomain(UploadJob job) {
    return domain.UploadJob(
      id: job.id,
      recordingId: job.recordingId,
      status: UploadJobStatus.values.firstWhere((s) => s.name == job.status),
      totalChunks: job.totalChunks,
      uploadedChunks: job.uploadedChunks,
      lastAttemptAt: job.lastAttemptAt,
      createdAt: job.createdAt,
    );
  }
}
