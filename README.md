# Scribble — Clinical Scribe Mobile App (v1.2)

> **Updated**: Optimized for future BLoC migration - clean separation of navigation and state management
> 
> **Architecture**: Standard Flutter apps + GoRouter + GetX (presentation layer only)

A Flutter mobile application for physicians to record, encrypt, and manage clinical encounters with patients.

## Project Overview

- **Type**: Clinical scribe application
- **Architecture**: GetX + Clean Architecture (Data/Domain/Presentation layers)
- **Timeline**: 3 weeks to v1 iOS sign-off
- **Platform**: iOS-primary (iOS 15+), Android 8+ secondary
- **Testing**: Developer manual testing (no TDD in v1)

## Architecture

### Clean Architecture Layers

```
lib/app/
├── core/                  # Cross-cutting concerns, no Flutter deps
│   ├── constants/         # App constants, enums
│   ├── error/             # Failure types, Result<T>
│   ├── mixins/            # DisposableMixin, LoggerMixin, LifecycleAwareMixin
│   ├── storage/           # Secure storage, cache wrappers
│   └── concurrency/       # Isolate pool management
├── data/                  # Implements domain interfaces
│   ├── database/          # Drift schema, DAOs
│   ├── repositories/      # Repository implementations
│   ├── datasources/       # Local data sources, upload sinks
│   └── models/            # Data models, mappers
├── domain/                # Pure Dart - business logic
│   ├── entities/          # Recording, Segment, Chunk, UploadJob
│   ├── repositories/      # Repository interfaces
│   ├── usecases/          # StartRecording, PauseRecording, etc.
│   ├── interfaces/        # V2 boundary interfaces (stubbed in v1)
│   └── strategy/          # RecordingStrategy (LiveChunk, RecordFull)
├── presentation/          # GetX controllers, screens
│   ├── modules/           # Feature modules
│   └── widgets/           # Shared UI components
├── services/              # GetX services (app-wide singletons)
└── routes/                # GoRouter configuration
```

### Key Design Principles

- **SOLID**: Single responsibility use cases, open/closed strategies, dependency inversion
- **Repository Pattern**: Domain defines interfaces, data implements
- **Result Type**: Functional error handling with `Result<T>` monad
- **V1/V2 Boundary**: V2 interfaces stubbed in v1, real implementations in v2

## Recording Modes

### Live-Chunk Mode
- Record → chunk (cipher-aligned) → encrypt (isolate) → hash → enqueue → upload
- Chunks process concurrently while recording continues
- Paused sessions continue processing already-captured chunks

### Record-Full Mode
- Record complete session → stitch segments → encode MP3 → encrypt → hash → enqueue → upload
- Paused sessions sit idle until resumed or stopped

### Simultaneous Sessions
- **One active, many paused** model
- Manual pause required before starting/resuming another session
- No auto-pause behavior

## Database Schema (Drift)

### Tables
- **recordings**: Main recording metadata
- **segments**: Continuous recording segments (created on pause/resume)
- **chunks**: Encrypted audio chunks with state machine
- **upload_jobs**: Upload progress tracking

### Chunk State Machine
```
pending → encrypting → ready → uploading → uploaded → confirmed → done
                                  ↓
                                failed → retrying → dead (v2)
```

## Setup Instructions

### Prerequisites
- Flutter SDK 3.0+
- iOS: Xcode 14+, iOS 15+ device/simulator
- Android: Android Studio, Android 8+ device/emulator

### Installation

1. **Install dependencies**:
```bash
flutter pub get
```

2. **Generate drift code**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. **Run on iOS**:
```bash
flutter run -d ios
```

4. **Run on Android**:
```bash
flutter run -d android
```

### Permissions

**iOS (Info.plist)**:
- `NSMicrophoneUsageDescription`: Microphone access for recording
- `UIBackgroundModes`: Audio background mode

**Android (AndroidManifest.xml)**:
- `RECORD_AUDIO`: Microphone recording
- `FOREGROUND_SERVICE`: Background recording
- `FOREGROUND_SERVICE_MICROPHONE`: Microphone foreground service

## Key Dependencies

| Category | Package | Purpose |
|---|---|---|
| State/DI | `get` | State management, DI, navigation |
| Routing | `go_router` | Declarative routing |
| Database | `drift` + `drift_flutter` | Relational DB with reactive streams |
| Audio | `record`, `just_audio`, `audio_session` | Recording and playback |
| Crypto | `encrypt`, `crypto` | AES-GCM encryption, SHA-256 |
| Concurrency | `isolate_manager`, `chunked_stream` | Off-UI crypto, cipher-aligned chunking |
| Storage | `hive`, `flutter_secure_storage` | Cache, secure key storage |
| Background | `flutter_background_service`, `flutter_foreground_task` | Process persistence |

## V1 Features

✅ **Completed in v1**:
- Multi-session pause/resume
- Background/screen-lock recording continuity
- Two recording modes (live-chunk, record-full)
- Encrypted output (.xsba format)
- Mock upload queue (local sent/ directory)
- Drift database with reactive streams
- UpdateRecordingStatus metadata assembly

🚧 **Deferred to v2**:
- Real API integration (Dio, auth, upload)
- Firebase (Firestore, FCM, auth)
- Crash/kill recovery
- Retry/backoff with dead-letter
- At-rest DB encryption
- Mic/input selection
- Call autopause, BT route-change
- TDD and comprehensive testing

## Development Workflow

### 1. Run Codegen
When modifying drift tables or injectable services:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Development Flow
```bash
# Watch for changes and rebuild
flutter pub run build_runner watch --delete-conflicting-outputs

# Run app in debug mode
flutter run
```

### 3. Testing
Manual testing checklist (v1):
- [ ] Start recording (both modes)
- [ ] Pause/resume recording
- [ ] Switch between sessions
- [ ] Background continuity (home button)
- [ ] Screen-lock continuity
- [ ] App-switch continuity
- [ ] Stop and check encryption

## Milestone Gates

### M1 (Week 1)
✅ Multi-session pause/resume survives background and screen-lock

### M2 (Week 2)
✅ Both modes produce encrypted + hashed MP3s with metadata

### M3 (Week 3)
✅ Shippable iOS TestFlight build

## V2 Roadmap

V2 adds real implementations behind the v1 boundary interfaces:
- `UploadSink`: URLSession (iOS) / WorkManager (Android)
- `KeyProvider`: CipherKeySettings from DeviceConfig API
- `AuthGate`: DeviceConfig → Login → MFA flow
- `ConfigSource`: Remote config with feature flags
- `Telemetry`: Firestore logging
- Database encryption, PHI-safe logging
- Retry/backoff queue logic
- Crash/kill recovery

## Architecture Decisions

| Decision | Rationale |
|---|---|
| GetX over BLoC | Faster scaffolding, solo dev; Clean layers enable future BLoC migration |
| Drift over Isar | Relational semantics for queue, FK constraints, transactions, migrations |
| Dart crypto over native | Production app already uses Dart impl round-tripping with backend |
| Plugin recording | Session lengths (<2 hrs) don't require native; graduate only if soak fails |
| No TDD in v1 | Timeline constraint; pure Dart domain enables v2 test coverage |

## Project Context

This project was developed with full architecture and planning completed upfront:
- Complete domain model defined
- All repository interfaces locked
- V1/V2 boundary explicitly scoped
- 3-week milestone structure with VP-level gates
- iOS-first approach (Android same build, lower priority)

For full context, refer to `Scribble_V1_Master_Context.md`.

## License

Internal pilot project — proprietary.
