import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:scribble/app/core/error/result.dart';
import 'package:scribble/app/domain/interfaces/v2_boundaries.dart';

import '../../../core/error/failures.dart';

/// V1 STUB: Mock upload sink - writes to local sent/ directory
class MockUploadSink implements UploadSink {
  @override
  Future<Result<void>> uploadChunk({
    required String chunkId,
    required String recordingId,
    required int sequence,
    required String filePath,
    required String hash,
  }) async {
    try {
      // In v1: copy file to sent/ directory to simulate upload
      final appDir = await getApplicationDocumentsDirectory();
      final sentDir = Directory('${appDir.path}/sent');

      if (!await sentDir.exists()) {
        await sentDir.create(recursive: true);
      }

      final sourceFile = File(filePath);
      // Include sequence in filename for tracking
      final targetFile = File('${sentDir.path}/${recordingId}_seq${sequence}_$chunkId.xsba');

      await sourceFile.copy(targetFile.path);

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 100));

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkFailure(
          message: 'Mock upload failed',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> isChunkUploaded(String chunkId) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/sent/$chunkId.xsba');
      return Result.success(await file.exists());
    } catch (e) {
      return Result.failure(
        NetworkFailure(
          message: 'Failed to check upload status',
          originalError: e,
        ),
      );
    }
  }
}

/// V1 STUB: Local test key provider - hardcoded AES key
class LocalTestKeyProvider implements KeyProvider {
  // WARNING: Hardcoded test key for v1 only
  static const String _testKey = 'test_encryption_key_32_bytes!!!';

  @override
  Future<Result<String>> getEncryptionKey() async {
    return Result.success(_testKey);
  }

  @override
  Future<Result<String>> getKeyVersion() async {
    return Result.success('v1_test');
  }

  @override
  Future<Result<bool>> isKeyExpired() async {
    return Result.success(false); // Never expires in v1
  }
}

/// V1 STUB: Static config from JSON asset
class StaticConfigSource implements ConfigSource {
  final Map<String, dynamic> _config = {
    'chunkSize': 8192,
    'maxRetries': 3,
    'uploadTimeout': 300,
  };

  @override
  Future<Result<T>> get<T>(String key) async {
    try {
      if (_config.containsKey(key)) {
        return Result.success(_config[key] as T);
      }
      return Result.failure(
        ValidationFailure(message: 'Config key not found: $key'),
      );
    } catch (e) {
      return Result.failure(
        UnknownFailure(
          message: 'Failed to get config',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> isFeatureEnabled(String featureName) async {
    // All features enabled in v1
    return Result.success(true);
  }

  @override
  Future<Result<void>> refresh() async {
    // No-op in v1
    return Result.success(null);
  }
}

/// V1 STUB: No-op auth gate - always authenticated
class NoOpAuthGate implements AuthGate {
  @override
  Future<Result<bool>> isAuthenticated() async {
    return Result.success(true); // Always authenticated in v1
  }

  @override
  Future<Result<String>> getAuthToken() async {
    return Result.success('test_token_v1');
  }

  @override
  Future<Result<String>> refreshToken() async {
    return Result.success('test_token_v1');
  }

  @override
  Future<Result<void>> logout() async {
    return Result.success(null); // No-op in v1
  }
}

/// V1 STUB: Console telemetry - prints to logcat
class ConsoleTelemetry implements Telemetry {
  @override
  Future<void> logEvent({
    required String event,
    Map<String, dynamic>? parameters,
  }) async {
    print('[TELEMETRY] Event: $event ${parameters != null ? 'Params: $parameters' : ''}');
  }

  @override
  Future<void> logError({
    required String error,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) async {
    print('[TELEMETRY] Error: $error');
    if (stackTrace != null) {
      print('[TELEMETRY] Stack: $stackTrace');
    }
    if (context != null) {
      print('[TELEMETRY] Context: $context');
    }
  }
}

/// V1 STUB: Seed appointments from local fixtures
class SeedAppointmentSource implements AppointmentSource {
  @override
  Future<Result<List<Map<String, dynamic>>>> getAppointments({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // Mock appointments for testing
    final appointments = [
      {
        'id': 'apt_1',
        'patientName': 'John Doe',
        'dateTime': DateTime.now().toIso8601String(),
        'type': 'Consultation',
      },
      {
        'id': 'apt_2',
        'patientName': 'Jane Smith',
        'dateTime': DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        'type': 'Follow-up',
      },
    ];

    return Result.success(appointments);
  }

  @override
  Future<Result<Map<String, dynamic>?>> getAppointment(String id) async {
    final appointments = await getAppointments(
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (appointments.isSuccess) {
      final appointment = appointments.dataOrNull!.firstWhere((a) => a['id'] == id, orElse: () => {});
      return Result.success(appointment.isNotEmpty ? appointment : null);
    }

    return Result.failure(appointments.failureOrNull!);
  }
}
