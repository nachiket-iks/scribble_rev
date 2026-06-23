# Future BLoC Migration Guide

## Why This Architecture Makes BLoC Migration Easy

The current architecture uses **standard Flutter apps** with **GoRouter** for navigation and **GetX** only for state management. This clean separation means migrating to BLoC touches only the presentation layer.

---

## 📊 What Changes vs What Stays

### ✅ **Stays Unchanged** (90% of code)

#### 1. **App Widget** - No changes
```dart
// This stays EXACTLY the same
MaterialApp.router(
  routerConfig: appRouter,  // ✅ No change
  theme: ThemeData(...),
);
```

#### 2. **Navigation** - No changes
```dart
// All navigation code stays the same
context.go('/home');
context.push('/recording/liveChunk');
context.pop();
```

#### 3. **Domain Layer** - No changes (Pure Dart)
```dart
// ✅ Entities - No GetX dependencies
class Recording { ... }
class UploadChunk { ... }

// ✅ Use Cases - No GetX dependencies
class StartRecordingUseCase { ... }
class PauseRecordingUseCase { ... }

// ✅ Repositories - No GetX dependencies
abstract class RecordingRepository { ... }
```

#### 4. **Data Layer** - No changes
```dart
// ✅ Repository implementations
class RecordingRepositoryImpl implements RecordingRepository { ... }

// ✅ Database (Drift)
class AppDatabase extends _$AppDatabase { ... }

// ✅ Services (mostly unchanged, see note below)
class AudioService { ... }
class CryptoService { ... }
```

#### 5. **Routes** - No changes
```dart
// ✅ GoRouter configuration stays the same
final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
```

---

### ⚠️ **Changes Required** (10% of code)

#### 1. **Controllers → Cubits/Blocs**

**Before (GetX)**:
```dart
class RecordingController extends GetxController {
  final Rx<Recording?> currentRecording = Rx<Recording?>(null);
  final RxList<Recording> pausedRecordings = <Recording>[].obs;
  
  Future<void> startRecording() async {
    // ... logic
    currentRecording.value = recording;
  }
}
```

**After (BLoC)**:
```dart
class RecordingCubit extends Cubit<RecordingState> {
  RecordingCubit() : super(RecordingInitial());
  
  Future<void> startRecording() async {
    // ... same logic
    emit(RecordingActive(recording));
  }
}
```

**Effort**: Replace controllers 1:1 with Cubits

---

#### 2. **Dependency Injection**

**Before (GetX)**:
```dart
// main.dart
Get.put<RecordingRepository>(
  RecordingRepositoryImpl(database: database),
  permanent: true,
);

Get.put<RecordingController>(
  RecordingController(
    recordingRepository: Get.find<RecordingRepository>(),
    audioService: Get.find<AudioService>(),
  ),
  permanent: true,
);
```

**After (get_it or Provider)**:
```dart
// main.dart with get_it
final getIt = GetIt.instance;

getIt.registerSingleton<RecordingRepository>(
  RecordingRepositoryImpl(database: database),
);

getIt.registerFactory<RecordingCubit>(
  () => RecordingCubit(
    recordingRepository: getIt<RecordingRepository>(),
    audioService: getIt<AudioService>(),
  ),
);
```

**Or with Provider**:
```dart
MultiProvider(
  providers: [
    Provider<RecordingRepository>(
      create: (_) => RecordingRepositoryImpl(database: database),
    ),
    BlocProvider<RecordingCubit>(
      create: (context) => RecordingCubit(
        recordingRepository: context.read<RecordingRepository>(),
        audioService: context.read<AudioService>(),
      ),
    ),
  ],
  child: MaterialApp.router(...),
)
```

**Effort**: Update DI setup once in main.dart

---

#### 3. **Screens - UI Updates**

**Before (GetX)**:
```dart
class RecordingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecordingController>();
    
    return Obx(() => Text(
      controller.currentRecording.value?.title ?? 'No recording'
    ));
  }
}
```

**After (BLoC)**:
```dart
class RecordingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordingCubit, RecordingState>(
      builder: (context, state) {
        if (state is RecordingActive) {
          return Text(state.recording.title);
        }
        return Text('No recording');
      },
    );
  }
}
```

**Effort**: Update UI widgets to use BlocBuilder/BlocConsumer

---

#### 4. **Services (Minor Updates)**

Services currently extend `GetxService` - change to regular classes:

**Before**:
```dart
class AudioService extends GetxService {
  final _isRecording = false.obs;
  // ...
}
```

**After**:
```dart
class AudioService {
  final _isRecording = ValueNotifier<bool>(false);
  // ... or use StreamController
}
```

**Effort**: Minor - mostly just removing `extends GetxService`

---

## 📋 **Migration Steps**

### Step 1: Add BLoC Dependencies
```yaml
dependencies:
  flutter_bloc: ^8.1.3
  # Remove: get: ^4.6.6
```

### Step 2: Replace DI (Choose One)
**Option A**: Keep GetX DI (works with BLoC!)
```dart
// GetX DI still works for injecting BLoCs
Get.put<RecordingCubit>(RecordingCubit(...));
final cubit = Get.find<RecordingCubit>();
```

**Option B**: Switch to get_it
```yaml
dependencies:
  get_it: ^7.6.4
```

**Option C**: Switch to Provider
```yaml
dependencies:
  provider: ^6.1.1
```

### Step 3: Convert Controllers to Cubits/Blocs
- One controller at a time
- Keep same business logic
- Just change state management mechanism

### Step 4: Update Screens
- Replace `Obx` with `BlocBuilder`
- Replace `Get.find()` with `context.read()`
- Replace `.obs` reactivity with state emissions

### Step 5: Update Services (Optional)
- Remove `extends GetxService`
- Replace `.obs` with `ValueNotifier` or `Stream`

### Step 6: Test & Clean Up
- Remove GetX dependency
- Remove unused imports
- Run tests

---

## 📊 **Effort Estimation**

| Component | Files to Change | Effort | Risk |
|-----------|----------------|--------|------|
| App Widget | 0 | ✅ None | None |
| Routes | 0 | ✅ None | None |
| Domain Layer | 0 | ✅ None | None |
| Data Layer | 0 | ✅ None | None |
| DI Setup | 1 (main.dart) | 🟡 Low | Low |
| Controllers | ~5 files | 🟡 Medium | Low |
| Screens | ~5 files | 🟡 Medium | Low |
| Services | ~3 files | 🟢 Minor | Low |
| **Total** | **~14 files** | **2-3 days** | **Low** |

---

## 💡 **Pro Tips**

### 1. **Incremental Migration**
Migrate one feature at a time:
```
Day 1: Recording feature (RecordingController → RecordingCubit)
Day 2: Library feature (LibraryController → LibraryCubit)
Day 3: Playback feature (PlaybackController → PlaybackCubit)
```

### 2. **GetX DI Can Stay**
You can keep using GetX for DI even with BLoC:
```dart
// This works!
Get.put<RecordingCubit>(RecordingCubit(...));
final cubit = Get.find<RecordingCubit>();
```

### 3. **Domain Layer is King**
Since domain layer has zero GetX dependencies, all your business logic is safe:
- ✅ Use cases work as-is
- ✅ Entities work as-is
- ✅ Repositories work as-is

### 4. **Services Can Use Streams**
If you want framework-agnostic services:
```dart
class AudioService {
  final _recordingStateController = StreamController<bool>.broadcast();
  Stream<bool> get recordingState => _recordingStateController.stream;
  
  void startRecording() {
    _recordingStateController.add(true);
  }
}

// Works with both GetX and BLoC!
```

---

## 🎯 **Why This Architecture Wins**

### Comparison: Tight Coupling vs Clean Separation

#### ❌ **If We Used GetX Apps** (Avoided)
```
GetMaterialApp.router  ← Coupled to GetX
GetX Routing           ← Coupled to GetX
GetX Controllers       ← Coupled to GetX
Domain                 ← Would need GetX imports
```
**Migration**: 60+ files, 1-2 weeks, high risk

#### ✅ **Current Architecture** (We Have)
```
MaterialApp.router     ← Framework standard
GoRouter              ← Independent
GetX Controllers      ← Only here
Domain (Pure Dart)    ← GetX-free
```
**Migration**: ~14 files, 2-3 days, low risk

---

## ✅ **Summary**

**Current State**: 
- Navigation: GoRouter (independent)
- State: GetX (presentation layer only)
- Domain: Pure Dart (framework-agnostic)

**Future BLoC Migration**:
- ✅ 90% of code unchanged
- ✅ Domain/data layers untouched
- ✅ Navigation/routing untouched
- ⚠️ Only controllers & screens update
- 📅 2-3 days effort
- 🎯 Low risk

**The architecture is already BLoC-ready!** 🚀
