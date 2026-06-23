import 'package:scribble/app/core/constants/app_constants.dart';

/// Recording entity - represents a clinical encounter recording
class Recording {
  final String id;
  final String title;
  final RecordingMode mode;
  final RecordingStatus status;
  final String clientCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalDurationMs;
  final int totalParts;
  final String? computedHashKey;
  final String? metadataJson;
  
  const Recording({
    required this.id,
    required this.title,
    required this.mode,
    required this.status,
    required this.clientCode,
    required this.createdAt,
    required this.updatedAt,
    required this.totalDurationMs,
    required this.totalParts,
    this.computedHashKey,
    this.metadataJson,
  });
  
  /// Create a copy with updated fields
  Recording copyWith({
    String? id,
    String? title,
    RecordingMode? mode,
    RecordingStatus? status,
    String? clientCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalDurationMs,
    int? totalParts,
    String? computedHashKey,
    String? metadataJson,
  }) {
    return Recording(
      id: id ?? this.id,
      title: title ?? this.title,
      mode: mode ?? this.mode,
      status: status ?? this.status,
      clientCode: clientCode ?? this.clientCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalDurationMs: totalDurationMs ?? this.totalDurationMs,
      totalParts: totalParts ?? this.totalParts,
      computedHashKey: computedHashKey ?? this.computedHashKey,
      metadataJson: metadataJson ?? this.metadataJson,
    );
  }
  
  /// Get duration as a Duration object
  Duration get duration => Duration(milliseconds: totalDurationMs);
  
  /// Format duration as HH:MM:SS
  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recording &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'Recording(id: $id, title: $title, mode: $mode, status: $status, duration: $formattedDuration)';
  }
}
