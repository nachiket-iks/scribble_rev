import 'package:scribble/app/core/error/result.dart';

/// Interface for uploading encrypted chunks (v2 boundary)
abstract class UploadSink {
  /// Upload a chunk to backend
  /// v1: MockUploadSink - writes to local sent/ directory
  /// v2: NativeUploadSink - URLSession / WorkManager
  Future<Result<void>> uploadChunk({
    required String chunkId,
    required String recordingId,
    required int sequence,        // CRITICAL: Chunk sequence number
    required String filePath,
    required String hash,
  });
  
  /// Check upload status
  Future<Result<bool>> isChunkUploaded(String chunkId);
}

/// Interface for providing encryption keys (v2 boundary)
abstract class KeyProvider {
  /// Get encryption key
  /// v1: LocalTestKeyProvider - hardcoded test key
  /// v2: ConfigKeyProvider - from CipherKeySettings API
  Future<Result<String>> getEncryptionKey();
  
  /// Get key version
  Future<Result<String>> getKeyVersion();
  
  /// Check if key is expired
  Future<Result<bool>> isKeyExpired();
}

/// Interface for app configuration (v2 boundary)
abstract class ConfigSource {
  /// Get configuration value
  /// v1: StaticConfig - JSON asset
  /// v2: RemoteConfigSource - DeviceConfig API
  Future<Result<T>> get<T>(String key);
  
  /// Check if feature is enabled
  Future<Result<bool>> isFeatureEnabled(String featureName);
  
  /// Refresh configuration
  Future<Result<void>> refresh();
}

/// Interface for authentication (v2 boundary)
abstract class AuthGate {
  /// Check if user is authenticated
  /// v1: NoOpAuthGate - always returns true
  /// v2: RealAuthGate - DeviceConfig → Login → MFA
  Future<Result<bool>> isAuthenticated();
  
  /// Get auth token
  Future<Result<String>> getAuthToken();
  
  /// Refresh auth token
  Future<Result<String>> refreshToken();
  
  /// Logout
  Future<Result<void>> logout();
}

/// Interface for telemetry/logging (v2 boundary)
abstract class Telemetry {
  /// Log event
  /// v1: ConsoleTelemetry - print to logcat
  /// v2: FirestoreTelemetry - Firestore collection
  Future<void> logEvent({
    required String event,
    Map<String, dynamic>? parameters,
  });
  
  /// Log error
  Future<void> logError({
    required String error,
    String? stackTrace,
    Map<String, dynamic>? context,
  });
}

/// Interface for appointment data (v2 boundary)
abstract class AppointmentSource {
  /// Get appointments for a date range
  /// v1: SeedAppointments - local fixtures
  /// v2: FirestoreAppointmentSource - Firestore query
  Future<Result<List<Map<String, dynamic>>>> getAppointments({
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Get appointment by ID
  Future<Result<Map<String, dynamic>?>> getAppointment(String id);
}
