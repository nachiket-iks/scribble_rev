/// Segment entity - represents a continuous recording segment
/// (created each time recording is paused/resumed)
class Segment {
  final String id;
  final String recordingId;
  final int index;
  final DateTime startedAt;
  final DateTime? pausedAt;
  final DateTime? resumedAt;
  final DateTime? stoppedAt;
  final String? filePath; // Temp plaintext file (full mode only)
  
  const Segment({
    required this.id,
    required this.recordingId,
    required this.index,
    required this.startedAt,
    this.pausedAt,
    this.resumedAt,
    this.stoppedAt,
    this.filePath,
  });
  
  /// Create a copy with updated fields
  Segment copyWith({
    String? id,
    String? recordingId,
    int? index,
    DateTime? startedAt,
    DateTime? pausedAt,
    DateTime? resumedAt,
    DateTime? stoppedAt,
    String? filePath,
  }) {
    return Segment(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      index: index ?? this.index,
      startedAt: startedAt ?? this.startedAt,
      pausedAt: pausedAt ?? this.pausedAt,
      resumedAt: resumedAt ?? this.resumedAt,
      stoppedAt: stoppedAt ?? this.stoppedAt,
      filePath: filePath ?? this.filePath,
    );
  }
  
  /// Calculate segment duration
  Duration get duration {
    final endTime = stoppedAt ?? pausedAt ?? DateTime.now();
    final startTime = resumedAt ?? startedAt;
    return endTime.difference(startTime);
  }
  
  /// Check if segment is currently active
  bool get isActive => pausedAt == null && stoppedAt == null;
  
  /// Check if segment is paused
  bool get isPaused => pausedAt != null && stoppedAt == null;
  
  /// Check if segment is stopped
  bool get isStopped => stoppedAt != null;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Segment &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'Segment(id: $id, recordingId: $recordingId, index: $index, isActive: $isActive)';
  }
}
