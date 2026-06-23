/// Core constants for Scribble app - Optimized for low networks and devices
class AppConstants {
  // App info
  static const String appName = 'Scribble';
  static const String appVersion = '1.0.0';
  
  // ============================================================================
  // CRYPTO CONSTANTS (for encryption alignment)
  // ============================================================================
  static const int cipherChunkSize = 8192; // Cipher-aligned chunks for AES-GCM
  static const int nonceSize = 12;
  static const int tagSize = 16;
  static const String encryptedFileExtension = '.xsba';
  
  // ============================================================================
  // UPLOAD CONSTANTS (for network efficiency)
  // ============================================================================
  // Base upload chunk size - optimized for low networks
  static const int uploadChunkSize = 5 * 1024 * 1024; // 5 MB base size
  
  // Adaptive chunk sizing based on network quality
  static const int minUploadChunkSize = 1 * 1024 * 1024; // 1 MB for very slow
  static const int maxUploadChunkSize = 10 * 1024 * 1024; // 10 MB for fast
  
  // Network quality thresholds (in Kbps)
  static const int lowNetworkThreshold = 100; // < 100 Kbps = low
  static const int mediumNetworkThreshold = 500; // 100-500 Kbps = medium
  
  // ============================================================================
  // AUDIO CONSTANTS (optimized for file size)
  // ============================================================================
  static const String audioFormat = 'aac'; // AAC for better compression
  static const String audioFileExtension = '.m4a'; // AAC container
  static const int sampleRate = 44100;
  static const int bitRate = 64000; // 64 Kbps for voice (optimized)
  static const int numChannels = 1; // Mono for voice (saves 50%)
  
  // Estimated file sizes: 64 Kbps mono = ~28 MB per hour
  static const int estimatedBytesPerHour = 28 * 1024 * 1024;
  
  // ============================================================================
  // DATABASE
  // ============================================================================
  static const String databaseName = 'scribble.db';
  static const int databaseVersion = 1;
  
  // ============================================================================
  // FILE PATHS
  // ============================================================================
  static const String encryptedDir = 'encrypted';
  static const String tempDir = 'temp';
  static const String cacheDir = 'cache'; // For streaming audio
  static const String sentDir = 'sent';
  
  // ============================================================================
  // SECURE STORAGE KEYS
  // ============================================================================
  static const String encryptionKeyStorageKey = 'encryption_key';
  static const String authTokenStorageKey = 'auth_token';
  
  // ============================================================================
  // HIVE BOXES
  // ============================================================================
  static const String configBoxName = 'config';
  static const String prefsBoxName = 'prefs';
  
  // ============================================================================
  // RECORDING
  // ============================================================================
  static const int maxSimultaneousSessions = 10;
  static const Duration minSegmentDuration = Duration(seconds: 1);
  
  // ============================================================================
  // QUEUE & RETRY LOGIC (optimized for low networks)
  // ============================================================================
  static const int maxRetryCount = 5; // More retries for unreliable networks
  static const Duration initialRetryDelay = Duration(seconds: 30);
  static const double retryBackoffMultiplier = 2.0; // Exponential backoff
  static const Duration maxRetryDelay = Duration(minutes: 10);
  static const Duration uploadTimeout = Duration(minutes: 8);
  
  // ============================================================================
  // PERFORMANCE (for low-end devices)
  // ============================================================================
  static const int maxConcurrentEncryptions = 2;
  static const int maxConcurrentUploads = 1; // Sequential for order guarantee
  static const int chunkProcessingBatchSize = 5;
  static const Duration processingBatchDelay = Duration(milliseconds: 500);
  static const int maxQueryResultsPerBatch = 20;
  
  // ============================================================================
  // BACKGROUND SERVICE
  // ============================================================================
  static const String notificationChannelId = 'scribble_recording';
  static const String notificationChannelName = 'Recording Service';
  static const int foregroundServiceNotificationId = 888;
  
  // ============================================================================
  // API & NETWORK
  // ============================================================================
  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration apiConnectTimeout = Duration(seconds: 30);
  static const Duration apiReceiveTimeout = Duration(minutes: 5);
  static const bool enableRequestCancellation = true;
}

/// Recording mode enum
enum RecordingMode {
  liveChunk,
  recordFull;
  
  String get displayName {
    switch (this) {
      case RecordingMode.liveChunk:
        return 'Live Chunk';
      case RecordingMode.recordFull:
        return 'Record Full';
    }
  }
}

/// Recording status enum
enum RecordingStatus {
  idle,
  recording,
  paused,
  stopped,
  processing,
  queued,
  uploading,
  done,
  failed;
  
  bool get isActive => this == RecordingStatus.recording;
  bool get isPaused => this == RecordingStatus.paused;
  bool get isComplete => this == RecordingStatus.done;
  bool get canResume => isPaused;
}

/// Chunk status enum
enum ChunkStatus {
  pending,
  encrypting,
  ready,
  uploading,
  uploaded,
  confirmed,
  failed,
  dead;
  
  bool get isProcessable => this == ChunkStatus.pending || this == ChunkStatus.ready;
  bool get isComplete => this == ChunkStatus.confirmed;
  bool get requiresRetry => this == ChunkStatus.failed;
}

/// Upload job status enum
enum UploadJobStatus {
  pending,
  running,
  paused,
  done,
  failed;
  
  bool get isActive => this == UploadJobStatus.running;
  bool get isComplete => this == UploadJobStatus.done;
}

/// Network quality enum for adaptive chunk sizing
enum NetworkQuality {
  low,    // < 100 Kbps
  medium, // 100-500 Kbps
  high;   // > 500 Kbps
  
  /// Get upload chunk size for this network quality
  int get uploadChunkSize {
    switch (this) {
      case NetworkQuality.low:
        return AppConstants.minUploadChunkSize; // 1 MB
      case NetworkQuality.medium:
        return AppConstants.uploadChunkSize; // 5 MB
      case NetworkQuality.high:
        return AppConstants.maxUploadChunkSize; // 10 MB
    }
  }
}
