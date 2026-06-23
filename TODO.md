# Development TODO & Implementation Notes

## Immediate Next Steps

### 1. Generate Drift Code (REQUIRED)
```bash
cd /home/claude/scribble
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate `lib/app/data/database/database.g.dart` with the actual drift implementation.

### 2. Complete Recording Strategy Implementations

**Current Status**: Strategy interfaces exist but need full implementation.

**LiveChunkStrategy** needs:
- `chunked_stream` integration for cipher-aligned chunking
- `isolate_manager` pool for parallel encryption
- Chunk creation and status updates
- Integration with CryptoService

**RecordFullStrategy** needs:
- Segment file stitching logic
- MP3 encoding (using `ffmpeg_kit_flutter` or similar)
- File encryption after stitching
- Temp file cleanup

### 3. Complete CryptoService Implementation

**Current**: Simplified stubs
**Needed**:
- Full AES-GCM encryption using `encrypt` package
- SHA-256 hashing using `crypto` package
- `isolate_manager` integration for off-UI processing
- Key retrieval from `KeyProvider`

Example implementation pattern:
```dart
Future<Result<String>> encryptFile({
  required String inputPath,
  required String outputPath,
}) async {
  // Get key from KeyProvider
  final keyResult = await _keyProvider.getEncryptionKey();
  if (keyResult.isFailure) return Result.failure(keyResult.failureOrNull!);
  
  // Run encryption in isolate
  final isolateResult = await IsolateManager.compute(
    _encryptInIsolate,
    {
      'inputPath': inputPath,
      'outputPath': outputPath,
      'key': keyResult.dataOrNull!,
    },
  );
  
  return isolateResult;
}

static Future<String> _encryptInIsolate(Map<String, dynamic> params) async {
  // Actual AES-GCM encryption logic here
  // Using production app's proven implementation
}
```

### 4. Complete AudioService Integration

**Current**: Basic recording scaffolding
**Needed**:
- Full `audio_session` configuration
- Interruption handling (calls, Siri, etc.)
- Stream-based audio data callback for live-chunk mode
- Proper background audio mode setup

### 5. Implement RecordingMetadataBuilder

**Location**: `lib/app/domain/entities/recording_metadata.dart` (entity exists)
**Needed**: Builder class

```dart
class RecordingMetadataBuilder {
  Future<RecordingMetadata> build({
    required Recording recording,
    required List<Segment> segments,
    required String hash,
    required int fileSizeBytes,
  }) async {
    // Build pause markers from segments
    final pauseMarkers = _buildPauseMarkers(segments);
    
    // Calculate total duration
    final durationMs = _calculateTotalDuration(segments);
    
    return RecordingMetadata(
      recordingId: recording.id,
      clientCode: recording.clientCode,
      mode: recording.mode,
      totalParts: segments.length,
      durationMs: durationMs,
      startedAtLocal: segments.first.startedAt.toIso8601String(),
      startedAtUtc: segments.first.startedAt.toUtc().toIso8601String(),
      stoppedAtLocal: segments.last.stoppedAt?.toIso8601String(),
      stoppedAtUtc: segments.last.stoppedAt?.toUtc().toIso8601String(),
      pauseMarkers: pauseMarkers,
      computedHashKey: hash,
      fileSizeBytes: fileSizeBytes,
      audioFormat: 'mp3',
      isFinal: true,
      filePart: segments.length,
    );
  }
}
```

### 6. Implement Library Screen with Drift Streams

**Current**: Placeholder screen
**Needed**: Reactive recordings list

```dart
class LibraryController extends GetxController with DisposableMixin {
  final RecordingRepository _repository;
  final recordings = <Recording>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    listen(
      _repository.watchAllRecordings(),
      (list) => recordings.value = list,
    );
  }
}
```

### 7. Add Background Service Configuration

**iOS**: Already configured in Info.plist
**Android**: Needs `flutter_background_service` initialization

```dart
// In main.dart or service initialization
await FlutterBackgroundService().configure(
  androidConfiguration: AndroidConfiguration(
    onStart: onStart,
    isForegroundMode: true,
    notificationChannelId: 'scribble_recording',
    initialNotificationTitle: 'Scribble',
    initialNotificationContent: 'Recording in progress',
    foregroundServiceNotificationId: 888,
  ),
  iosConfiguration: IosConfiguration(
    autoStart: false,
    onForeground: onStart,
    onBackground: onIosBackground,
  ),
);
```

### 8. Add Wakelock Management

```dart
// In RecordingController
Future<void> startRecording(...) async {
  await WakelockPlus.enable();
  // ... existing start logic
}

Future<void> stopRecording() async {
  await WakelockPlus.disable();
  // ... existing stop logic
}
```

### 9. Error Handling & User Feedback

**Add to RecordingController**:
- Better error messages for different failure types
- Loading indicators during encryption/upload
- Progress tracking for long operations

### 10. Platform-Specific Polish

**iOS**:
- Proper Cupertino styling throughout
- Haptic feedback on important actions
- iOS-specific alerts and action sheets

**Android**:
- Material 3 theming
- Proper back button handling
- Android-specific notifications

## Testing Checklist

### M1 Verification (Week 1)
- [ ] Start recording → pause → home button → return → resume (audio continues)
- [ ] Start recording → lock screen → unlock → still recording
- [ ] Start recording → pause → start new → both in paused list
- [ ] Resume paused session (when no active session)
- [ ] Cannot resume paused session when another is active
- [ ] Multiple paused sessions display correctly

### M2 Verification (Week 2)
- [ ] Live-chunk mode produces .xsba files
- [ ] Record-full mode produces .xsba file after stop
- [ ] Encrypted files have correct hash
- [ ] Metadata JSON matches UpdateRecordingStatus schema
- [ ] Mock upload writes to sent/ directory
- [ ] Chunk state transitions in database

### M3 Verification (Week 3)
- [ ] iOS build compiles without errors
- [ ] App runs on iOS 15+ device
- [ ] Background recording works for 2+ hours
- [ ] All M1 and M2 tests pass
- [ ] No crashes during normal operation

## Known Limitations (v1)

1. **Encryption is stubbed**: Need to integrate production AES-GCM impl
2. **No MP3 encoding**: Full mode currently just copies file
3. **No chunking**: Live-chunk mode needs cipher-aligned chunking
4. **No real upload**: MockUploadSink writes locally
5. **No retry logic**: Failed uploads stay failed (v2 feature)
6. **No auth**: NoOpAuthGate always returns true
7. **No remote config**: StaticConfigSource uses hardcoded values

## Performance Considerations

1. **Isolates**: Crypto must run off-UI thread
2. **Database**: All chunk transitions in transactions
3. **Memory**: Stream audio data, don't accumulate in memory
4. **Battery**: Monitor background service battery usage

## Code Quality Notes

- All domain code is pure Dart (no Flutter imports)
- Repositories return Result<T> for error handling
- Use cases are single-purpose (SOLID)
- Mixins keep controllers clean
- V2 boundaries clearly marked with stubs

## Next Developer Handoff

When handing this off:
1. Run `flutter pub run build_runner build`
2. Verify drift generated code compiles
3. Test basic recording flow on device
4. Document any issues found
5. Priority: Complete crypto and strategy implementations
