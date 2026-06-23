import 'package:scribble/app/core/constants/app_constants.dart';

/// Pause marker - represents when recording was paused and resumed
class PauseMarker {
  final DateTime pausedAt;
  final DateTime? resumedAt;
  
  const PauseMarker({
    required this.pausedAt,
    this.resumedAt,
  });
  
  Map<String, dynamic> toJson() => {
    'pausedAt': pausedAt.toIso8601String(),
    if (resumedAt != null) 'resumedAt': resumedAt!.toIso8601String(),
  };
  
  factory PauseMarker.fromJson(Map<String, dynamic> json) {
    return PauseMarker(
      pausedAt: DateTime.parse(json['pausedAt']),
      resumedAt: json['resumedAt'] != null ? DateTime.parse(json['resumedAt']) : null,
    );
  }
}

/// Recording metadata - matches UpdateRecordingStatus API payload
class RecordingMetadata {
  final String recordingId;
  final String clientCode;
  final RecordingMode mode;
  final int totalParts;
  final int durationMs;
  final String startedAtLocal;
  final String startedAtUtc;
  final String? stoppedAtLocal;
  final String? stoppedAtUtc;
  final List<PauseMarker> pauseMarkers;
  final String computedHashKey;
  final int fileSizeBytes;
  final String audioFormat;
  final bool isFinal;
  final int filePart;
  
  const RecordingMetadata({
    required this.recordingId,
    required this.clientCode,
    required this.mode,
    required this.totalParts,
    required this.durationMs,
    required this.startedAtLocal,
    required this.startedAtUtc,
    this.stoppedAtLocal,
    this.stoppedAtUtc,
    required this.pauseMarkers,
    required this.computedHashKey,
    required this.fileSizeBytes,
    required this.audioFormat,
    required this.isFinal,
    required this.filePart,
  });
  
  /// Convert to JSON for API
  Map<String, dynamic> toJson() => {
    'recordingId': recordingId,
    'clientCode': clientCode,
    'mode': mode == RecordingMode.liveChunk ? 'liveChunk' : 'recordFull',
    'totalParts': totalParts,
    'durationMs': durationMs,
    'startedAtLocal': startedAtLocal,
    'startedAtUtc': startedAtUtc,
    if (stoppedAtLocal != null) 'stoppedAtLocal': stoppedAtLocal,
    if (stoppedAtUtc != null) 'stoppedAtUtc': stoppedAtUtc,
    'pauseMarkers': pauseMarkers.map((m) => m.toJson()).toList(),
    'computedHashKey': computedHashKey,
    'fileSizeBytes': fileSizeBytes,
    'audioFormat': audioFormat,
    'isFinal': isFinal,
    'filePart': filePart,
  };
  
  /// Create from JSON
  factory RecordingMetadata.fromJson(Map<String, dynamic> json) {
    return RecordingMetadata(
      recordingId: json['recordingId'],
      clientCode: json['clientCode'],
      mode: json['mode'] == 'liveChunk' ? RecordingMode.liveChunk : RecordingMode.recordFull,
      totalParts: json['totalParts'],
      durationMs: json['durationMs'],
      startedAtLocal: json['startedAtLocal'],
      startedAtUtc: json['startedAtUtc'],
      stoppedAtLocal: json['stoppedAtLocal'],
      stoppedAtUtc: json['stoppedAtUtc'],
      pauseMarkers: (json['pauseMarkers'] as List)
          .map((m) => PauseMarker.fromJson(m))
          .toList(),
      computedHashKey: json['computedHashKey'],
      fileSizeBytes: json['fileSizeBytes'],
      audioFormat: json['audioFormat'],
      isFinal: json['isFinal'],
      filePart: json['filePart'],
    );
  }
  
  @override
  String toString() {
    return 'RecordingMetadata(recordingId: $recordingId, mode: $mode, duration: ${durationMs}ms, parts: $totalParts)';
  }
}
