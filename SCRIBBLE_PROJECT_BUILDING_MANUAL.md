# Scribble Project Building Manual

## Table of Contents
1. [Overview](#overview)
2. [Feature Development Workflow](#feature-development-workflow)
3. [Brainstorming Phase](#brainstorming-phase)
4. [Finalization Phase](#finalization-phase)
5. [Code Generation Phase](#code-generation-phase)
6. [Implementation Phase](#implementation-phase)
7. [Architecture Guidelines](#architecture-guidelines)
8. [CTO Requirements Checklist](#cto-requirements-checklist)
9. [Testing Strategy](#testing-strategy)
10. [Documentation Requirements](#documentation-requirements)
11. [Integration Points](#integration-points)
12. [Troubleshooting](#troubleshooting)

---

## Overview

This manual defines the **optimal workflow for building features** in the Scribble project. 

**Key Principle**: Separate planning from coding through structured phases.

**Phases**:
1. **Brainstorming** (Chat discussion)
2. **Finalization** (Design lock-down)
3. **Code Generation** (When ready)
4. **Implementation** (Your IDE/Claude Code)

---

## Feature Development Workflow

### 🔄 The Complete Cycle

```
START
  ↓
[Phase 1: Brainstorming]
  - Describe feature
  - Ask clarifying questions
  - Explore options
  - Discuss trade-offs
  ↓
[Phase 2: Finalization]
  - Lock down design
  - Validate architecture
  - Check CTO requirements
  - Define interfaces
  ↓
YOU SAY: "Ready to code"
  ↓
[Phase 3: Code Generation]
  - Generate all files
  - Provide integration guide
  - Include testing checklist
  - Document decisions
  ↓
[Phase 4: Implementation]
  - Copy code to your IDE
  - Test locally
  - Make adjustments if needed
  - Report results
  ↓
[Phase 1 Again: Next Feature]
```

---

## Brainstorming Phase

### When to Start
You describe what you want to build:

```
"I want to implement [FEATURE NAME].

Context:
- What it should do
- Why it's needed
- Any constraints

Questions:
- Should it work like [approach 1] or [approach 2]?
- How should it integrate with [existing service]?
- What about [edge case]?"
```

### What I Do
- ✅ Ask clarifying questions
- ✅ Explore different approaches
- ✅ Discuss trade-offs
- ✅ Validate against architecture
- ✅ Check CTO requirements
- ✅ Identify dependencies

### Example Brainstorm Session

**You Start**:
```
"I need to implement the UploadChunkAggregator service.

Context:
- Aggregates cipher chunks (8KB) into upload chunks (5-10 MB)
- For network efficiency
- Must maintain sequence order
- Used by QueueService

Questions:
- Should aggregation happen in memory or on disk?
- How to handle network quality detection?
- What if aggregation fails mid-way?"
```

**I Respond**:
```
Great questions. Let me explore this:

QUESTION 1: Memory vs Disk Aggregation
Option A (In-Memory):
  Pros: Fast, simple
  Cons: Uses RAM (bad for low-end devices with 3-hour recordings)
  
Option B (Disk-based):
  Pros: Memory efficient, can handle large files
  Cons: Slower, more file I/O
  
For low-end devices, Option B better. Agree?

QUESTION 2: Network Quality Detection
Should we:
- Detect via connectivity_plus package?
- Make it injectable/configurable?
- Adjust chunk size dynamically?

QUESTION 3: Failure Handling
If aggregation fails:
- Retry from last successful chunk?
- Rollback and restart?
- Partial upload allowed?

What's your thinking on these?
```

**You Clarify**:
```
"Option B (disk-based) - yes, better for low-end.

Network detection - yes use connectivity_plus,
make it injectable so we can mock for testing,
and adjust dynamically.

Failure - retry from last successful. 
No partial uploads until complete aggregation."
```

### How to Ask Good Questions

**Good Questions**:
- "Should this use isolates for crypto?"
- "How to handle concurrent requests?"
- "What's the timeout strategy?"
- "Should we cache results?"
- "How does this affect low-end devices?"

**Avoid Vague Questions**:
- ❌ "Is this good?"
- ❌ "Should I use approach X?"
- ❌ "What's the best way?"

**Instead Ask**:
- ✅ "Should I use isolates for CPU-bound crypto?"
- ✅ "Between approach X (fast, more memory) and approach Y (slower, less memory), which fits low-end devices better?"
- ✅ "How should timeouts work for slow networks?"

---

## Finalization Phase

### What Gets Locked Down

Once brainstorming reaches consensus, we finalize:

1. **Requirements** - What exactly will be built
2. **Interface** - How it connects to other parts
3. **Data Flow** - Input → Processing → Output
4. **Error Handling** - What goes wrong and why
5. **Testing Strategy** - How to verify it works
6. **Integration Points** - Where it plugs in

### Finalization Template

```
FEATURE: [Name]

FINAL DESIGN:
[Summary of what was decided]

INTERFACES:
- Class name, methods, parameters
- Return types (use Result<T>)
- Expected exceptions/failures

DATA FLOW:
Input → [Processing Steps] → Output

ERROR CASES:
1. When X happens → Return FailureY
2. When A happens → Return FailureB

DEPENDENCIES:
- Services used
- Repositories needed
- External libraries

INTEGRATION:
- Where it's used
- How it's injected into DI
- Which screens/controllers call it

CONSTRAINTS:
- Memory limits (low-end devices)
- Network conditions (slow/no connection)
- Concurrency limits

TESTING:
- Unit tests for...
- Integration tests for...
- Manual tests for...

READY FOR CODE? [YES/NO]
```

### Example Finalization

```
FEATURE: RequestTracker Service

FINAL DESIGN:
Tracks active API requests and cancels duplicates.
Thread-safe implementation using Map<String, CancelToken>.
Auto-cleanup after 30 minutes.
Logs all operations for debugging.

INTERFACE:
class RequestTracker {
  CancelToken trackRequest(String requestId);
  void completeRequest(String requestId);
  void cancelRequest(String requestId, [String reason]);
  void cancelAll([String reason]);
  bool isRequestActive(String requestId);
  int get activeRequestCount;
  void dispose();
}

DATA FLOW:
User clicks "Upload" 
  → Call trackRequest('upload_123')
  → Get CancelToken back
  → Pass to Dio.post(..., cancelToken: token)
  → Upload completes
  → Call completeRequest('upload_123')
  → Token cleaned up

If user clicks again before completion:
  → Call trackRequest('upload_123') again
  → Previous token cancelled automatically
  → New request starts

ERROR CASES:
- If request not found → Silent (already completed)
- If token already cancelled → Handled by Dio
- If dispose() called → All tokens cancelled

DEPENDENCIES:
- dio: ^5.4.0 (CancelToken)
- No other dependencies

INTEGRATION:
- Location: lib/app/core/concurrency/request_tracker.dart
- DI: Get.put<RequestTracker>(RequestTracker())
- Usage: In QueueService.uploadChunk()
- Screens: Handled via service, no UI changes needed

CONSTRAINTS:
- Thread-safe for concurrent requests
- Memory: One CancelToken per active request (~100 bytes each)
- Max requests tracked: Unlimited (practical limit ~1000)

TESTING:
- Unit test: trackRequest() creates token
- Unit test: Duplicate request cancels previous
- Unit test: completeRequest() removes from map
- Unit test: isRequestActive() works correctly
- Integration test: QueueService uses it correctly

READY FOR CODE? YES
```

---

## Code Generation Phase

### Signal Words (Use These to Trigger Code)

When you're ready for code generation, use:

- ✅ **"Ready to code"**
- ✅ **"Let's implement this"**
- ✅ **"Generate the code"**
- ✅ **"Show me the implementation"**
- ✅ **"Write it now"**
- ✅ **"Generate [FeatureName]"**

### What You Get

When you signal "Ready to code", I provide:

1. **Complete Source Files**
   - All Dart files needed
   - Copy-paste ready
   - No incomplete stubs

2. **Integration Instructions**
   ```
   Files to create:
   - lib/app/services/new_service.dart
   
   Files to modify:
   - lib/main.dart (add DI)
   - lib/app/services/existing_service.dart (integration)
   
   Import statements:
   - Add these to main.dart
   - Add these to services.dart
   ```

3. **Testing Checklist**
   ```
   Unit Tests:
   - [ ] Test case 1
   - [ ] Test case 2
   
   Integration Tests:
   - [ ] Integration test 1
   
   Manual Tests:
   - [ ] Test scenario 1
   - [ ] Test on low-end device
   - [ ] Test on slow network
   ```

4. **Documentation**
   - Code comments explaining why
   - Integration examples
   - Common pitfalls to avoid

---

## Implementation Phase

### After Code Generation

1. **Review the Code**
   - Read through all generated files
   - Understand the implementation
   - Ask questions if anything is unclear

2. **Copy to Your IDE/Claude Code**
   - Copy each file to the exact location specified
   - Check imports are correct
   - Verify no syntax errors

3. **Run Tests**
   ```bash
   # Generate any needed code (drift, etc.)
   flutter pub run build_runner build --delete-conflicting-outputs
   
   # Test
   flutter test
   ```

4. **Manual Testing**
   - Follow the testing checklist
   - Test on actual device if possible
   - Test edge cases

5. **Report Back**
   ```
   "I've implemented [Feature].
   
   Status:
   - ✅ Code compiles
   - ✅ Unit tests pass (X/Y tests)
   - ✅ Manual tests done (list results)
   
   Issues encountered:
   - [If any]
   
   Questions:
   - [If any]
   
   Ready for next feature."
   ```

---

## Architecture Guidelines

### Clean Architecture Layers

Every feature must respect these layers:

```
Presentation Layer
├── Screens (UI)
└── Controllers (GetX)

Domain Layer (Pure Dart - NO framework imports)
├── Entities
├── Use Cases
├── Repositories (interfaces)
└── Interfaces (for v2 boundaries)

Data Layer
├── Repositories (implementations)
├── Database (Drift)
└── Data Sources

Services Layer
├── Core Services (Audio, Crypto, Queue)
├── Infrastructure Services
└── Platform Adapters
```

### Rules for Each Layer

**Domain Layer** (MUST be framework-agnostic):
- ❌ No Flutter imports
- ❌ No GetX imports
- ❌ No plugin imports
- ✅ Pure Dart only
- ✅ Business logic only
- ✅ Interfaces and entities

**Data Layer** (Can use plugins):
- ✅ Use Drift, Dio, etc.
- ✅ Implement domain interfaces
- ✅ Map to domain entities
- ❌ No UI logic
- ❌ No business rules

**Presentation Layer** (UI logic):
- ✅ GetX Controllers
- ✅ Platform-specific widgets
- ✅ UI business logic (navigation, forms)
- ❌ Use cases (delegate to controllers)
- ❌ Data access (use repositories)

**Services Layer** (Cross-cutting):
- ✅ Audio, Crypto, Queue, etc.
- ✅ GetX Services (singletons)
- ✅ Platform adapters
- ❌ Business logic (belongs in domain)
- ❌ UI (belongs in presentation)

### Result<T> Pattern (Error Handling)

All public methods must return `Result<T>`:

```dart
// ✅ CORRECT
Future<Result<Recording>> startRecording(params) async {
  try {
    // Logic
    return Result.success(recording);
  } catch (e) {
    return Result.failure(RecordingFailure(...));
  }
}

// ❌ WRONG - Throws exception
Future<Recording> startRecording(params) async {
  // Logic
  return recording; // What if error?
}
```

### Repository Pattern

Every domain entity needs a repository interface:

```dart
// domain/repositories/
abstract class RecordingRepository {
  Future<Result<Recording>> createRecording(params);
  Future<Result<Recording>> getRecording(id);
  Stream<List<Recording>> watchAllRecordings();
}

// data/repositories/
class RecordingRepositoryImpl implements RecordingRepository {
  // Implement interface
}

// main.dart - DI
Get.put<RecordingRepository>(
  RecordingRepositoryImpl(database: database),
);
```

---

## CTO Requirements Checklist

### Every Feature Must Pass These Checks

When finalizing a feature, verify:

#### ✅ Low Network Support
- [ ] Works with 100 Kbps connection?
- [ ] Has retry logic with exponential backoff?
- [ ] Respects upload timeout settings?
- [ ] Handles connection drops gracefully?
- [ ] Can resume interrupted operations?

#### ✅ Low-End Device Support
- [ ] Memory usage < 10MB per operation?
- [ ] Uses isolates for CPU-bound tasks?
- [ ] Streams data (not holding in memory)?
- [ ] Batch processes large datasets?
- [ ] Throttles concurrent operations (max 2)?

#### ✅ Chunk Sequence Maintenance
- [ ] Upload chunks have sequence field?
- [ ] Sequence ordering enforced?
- [ ] Database UNIQUE constraint on (recordingId, sequence)?
- [ ] Upload happens sequentially (not parallel)?
- [ ] Sequence sent to backend?

#### ✅ API Request Cancellation
- [ ] Uses RequestTracker for all API calls?
- [ ] Duplicate requests cancelled automatically?
- [ ] Timeout after configured duration?
- [ ] Graceful handling of cancelled requests?

#### ✅ Edge Cases
- [ ] App kill mid-operation?
- [ ] Screen rotation during operation?
- [ ] Background → foreground transition?
- [ ] Multiple rapid user clicks?
- [ ] Network switches (WiFi → cellular)?
- [ ] Out of storage?
- [ ] Out of memory?

#### ✅ Logging & Debugging
- [ ] Uses LoggerMixin for all major events?
- [ ] Alice can inspect all API calls?
- [ ] Error logging includes context?
- [ ] Performance metrics logged?

#### ✅ Architecture Compliance
- [ ] Domain layer: Pure Dart?
- [ ] Data layer: Implements domain interfaces?
- [ ] Presentation: Uses GetX controllers?
- [ ] Services: Registered in DI?
- [ ] Result<T> pattern used?

### Checklist Template

Use this when finalizing features:

```
FEATURE: [Name]

CTO REQUIREMENTS:
- [ ] Low network: Retry logic, timeouts, resumable
- [ ] Low-end devices: Memory efficient, isolates, streaming
- [ ] Chunking: Sequence maintained, ordered upload
- [ ] Cancellation: RequestTracker integrated
- [ ] Edge cases: [List major edge cases tested]

ARCHITECTURE:
- [ ] Domain: Pure Dart
- [ ] Data: Implements domain interfaces
- [ ] Presentation: Uses GetX + GoRouter
- [ ] Services: Registered in DI
- [ ] Error handling: Result<T> pattern

READY FOR FINALIZATION? YES/NO
```

---

## Testing Strategy

### Test Pyramid for Scribble

```
           /\
          /  \        Integration Tests (5%)
         /____\       - Feature workflows
        /      \      - Component interaction
       /________\
      /          \    Unit Tests (70%)
     /____________\   - Business logic
    /              \  - Data transformations
   /________________\ - Error handling

   Manual Tests (25%)
   - Real devices
   - Network conditions
   - Edge cases
```

### Unit Testing Approach

```dart
// Test domain use cases (Pure Dart = easy to test)
test('StartRecordingUseCase creates recording', () async {
  final mockRepository = MockRecordingRepository();
  final useCase = StartRecordingUseCase(repository: mockRepository);
  
  final result = await useCase(StartRecordingParams(...));
  
  expect(result.isSuccess, true);
  expect(result.dataOrNull.status, RecordingStatus.recording);
});

// Test data transformations
test('ChunkRepositoryImpl maps Chunk to domain entity', () {
  final databaseChunk = Chunk(...);
  final domainChunk = repositoryImpl.mapToDomain(databaseChunk);
  
  expect(domainChunk.id, databaseChunk.id);
  expect(domainChunk.status, ChunkStatus.values.byName(databaseChunk.status));
});

// Test error cases
test('UploadChunk marked dead after max retries', () async {
  final chunk = UploadChunk(retryCount: 5);
  
  expect(chunk.canRetry(maxRetries: 5), false);
  expect(chunk.nextStatus(), ChunkStatus.dead);
});
```

### Integration Testing Approach

```dart
// Test service integration
test('QueueService uploads chunks in sequence', () async {
  // Setup
  final database = setupTestDatabase();
  final repository = ChunkRepositoryImpl(database: database);
  final uploadSink = MockUploadSink();
  final service = QueueService(
    chunkRepository: repository,
    uploadSink: uploadSink,
  );
  
  // Create test chunks
  await repository.createChunk(CreateUploadChunkParams(
    recordingId: 'rec1',
    sequence: 0,
    // ...
  ));
  
  // Execute
  await service.processQueue();
  
  // Verify sequence order
  expect(uploadSink.uploadedSequences, [0, 1, 2, 3, 4]);
});
```

### Manual Testing Checklist Template

```
FEATURE: [Name]

MANUAL TESTING CHECKLIST:

Happy Path:
- [ ] [Feature] works with normal input
- [ ] Expected output received
- [ ] Status updated correctly in DB

Edge Cases:
- [ ] Works on low-end device (test on actual device)
- [ ] Works on slow network (< 100 Kbps simulation)
- [ ] Works after app kill (pause recording → kill → reopen)
- [ ] Works after screen rotation
- [ ] Works with rapid user clicks

Error Handling:
- [ ] Network timeout → Shows error message
- [ ] Storage full → Handles gracefully
- [ ] Out of memory → Doesn't crash
- [ ] Concurrent operations conflict → Handled

Performance:
- [ ] Startup time: < 1 second
- [ ] Memory usage: < 50MB for 3-hour recording
- [ ] Battery drain: Reasonable for 8-hour day

Results:
- Device tested: [Model, OS version]
- Network conditions: [Speeds tested]
- Issues found: [List any]
- Overall: PASS / FAIL
```

---

## Documentation Requirements

### Every Feature Needs Documentation

When code is generated, I provide:

1. **Code Comments** (In the code)
   - Why this approach
   - What each method does
   - Edge cases handled
   - Examples of usage

2. **Integration Guide** (Text file)
   - Where to copy each file
   - What to modify
   - Import statements needed
   - DI setup needed

3. **Architecture Diagram** (If complex)
   - Data flow
   - Component interaction
   - Integration points

4. **Examples** (Code snippets)
   - How to use the feature
   - Common patterns
   - What to avoid

### Documentation Template

```markdown
# [Feature Name] Implementation

## Overview
[What it does and why]

## Architecture
[How it's organized]

## Key Components
1. [Class 1] - What it does
2. [Class 2] - What it does

## Data Flow
[Input] → [Processing] → [Output]

## Integration Points
- Location in codebase
- How it connects to other services
- Where it's used

## Usage Example
```dart
[Example code]
```

## Error Handling
- Case 1: [How it's handled]
- Case 2: [How it's handled]

## Testing
[How to test this feature]

## Performance Considerations
[Memory, CPU, network impact]

## Future Improvements
[What could be better in v2]
```

---

## Integration Points

### How Services Connect

```
Controller (Presentation Layer)
    ↓ uses
Use Cases (Domain Layer)
    ↓ uses
Repositories (Domain interfaces)
    ↓ implements
Repository Impl (Data Layer)
    ↓ uses
Services (Audio, Crypto, Queue)
    ↓ uses
Database (Drift)
    ↓ uses
External Services (API, FileSystem, Platform)
```

### Common Integration Patterns

#### Pattern 1: Service → Repository → Use Case → Controller
```dart
// Service does core work
class CryptoService {
  Future<Result<String>> encryptFile(path) { ... }
}

// Repository uses service
class RecordingRepositoryImpl {
  Future<Result<Recording>> saveRecording(recording) {
    final encrypted = await cryptoService.encryptFile(path);
    // Store in DB
  }
}

// Use case calls repository
class StopRecordingUseCase {
  Future<Result<void>> call(recordingId) {
    return repository.saveRecording(...);
  }
}

// Controller calls use case
class RecordingController {
  Future<void> stopRecording() {
    await stopRecordingUseCase(recordingId);
  }
}
```

#### Pattern 2: Request Tracking
```dart
// Service uses RequestTracker
class QueueService {
  Future<void> uploadChunk(chunk) {
    final token = requestTracker.trackRequest('upload_${chunk.id}');
    try {
      await uploadSink.uploadChunk(..., cancelToken: token);
    } finally {
      requestTracker.completeRequest('upload_${chunk.id}');
    }
  }
}
```

#### Pattern 3: Error Propagation
```dart
// Bottom layer: Return Result<T>
class ChunkRepositoryImpl {
  Future<Result<UploadChunk>> getChunk(id) {
    try {
      final chunk = await database.getUploadChunkById(id);
      return Result.success(chunk);
    } catch (e) {
      return Result.failure(DatabaseFailure(...));
    }
  }
}

// Middle layer: Check and propagate
class QueueService {
  Future<void> processQueue() {
    final result = await repository.getReadyChunks();
    if (result.isFailure) {
      logError(result.failureOrNull);
      return; // Handle gracefully
    }
    // Process chunks
  }
}

// Top layer: Show to user
class RecordingController {
  Future<void> startRecording() {
    final result = await startRecordingUseCase(...);
    if (result.isFailure) {
      Get.snackbar('Error', result.failureOrNull.message);
    }
  }
}
```

---

## Troubleshooting

### Common Issues & Solutions

#### Issue: "I don't know what to brainstorm"
**Solution**: 
1. Look at TODO.md for incomplete features
2. Review CTO requirements checklist
3. Check edge cases list
4. Start with: "I need to implement [Feature]. Should it work like [approach 1] or [approach 2]?"

#### Issue: "Brainstorming takes too long"
**Solution**:
1. Be more specific in initial description
2. Ask focused questions (not "how should I do this?")
3. Come with your own recommendation
4. Keep it to 2-3 rounds of discussion before "Ready to code"

#### Issue: "Code doesn't work after generation"
**Solution**:
1. Check imports are correct
2. Run `flutter pub get` after copying
3. Run code generation: `flutter pub run build_runner build`
4. Copy entire file, not just parts
5. Check file locations match exactly
6. Report specific error with context

#### Issue: "I'm not sure if design is final"
**Solution**: 
Ask these questions:
- [ ] Can I clearly explain what this does to someone else?
- [ ] Do I know how it integrates with other services?
- [ ] Can I list all the error cases?
- [ ] Do I know how to test it?
- [ ] Does it meet all CTO requirements?

If all YES → It's ready. Say "Ready to code"

#### Issue: "Generated code is too much"
**Solution**:
1. Ask for just one service at a time
2. Ask for interfaces/contracts before full implementation
3. Request incremental additions: "Generate part 1" then "Generate part 2"

---

## Quick Reference: Feature Development Checklist

```
STARTING A NEW FEATURE
├─ [ ] Know what you want to build
├─ [ ] Have 2-3 questions about approach
├─ [ ] Start with: "I want to implement [Feature]..."

BRAINSTORMING PHASE
├─ [ ] Discuss options
├─ [ ] Explore trade-offs
├─ [ ] Get clarification on all aspects
├─ [ ] Reach consensus on approach

FINALIZATION PHASE
├─ [ ] Interfaces are clear
├─ [ ] Data flow is mapped
├─ [ ] Error cases identified
├─ [ ] Integration points clear
├─ [ ] CTO requirements checked
├─ [ ] Testing strategy defined

CODE GENERATION PHASE
├─ [ ] Say "Ready to code"
├─ [ ] Receive complete files
├─ [ ] Get integration instructions
├─ [ ] Get testing checklist

IMPLEMENTATION PHASE
├─ [ ] Copy files to correct locations
├─ [ ] Fix any imports
├─ [ ] Run tests
├─ [ ] Manual testing on device
├─ [ ] Report results

NEXT FEATURE
└─ [ ] Repeat cycle
```

---

## Summary

This manual defines the **proven workflow** for building Scribble features:

1. **Describe** what you want (Brainstorming)
2. **Discuss** how to build it (Brainstorming)
3. **Decide** on design (Finalization)
4. **Signal** "Ready to code" (Code Generation)
5. **Implement** in your IDE (Implementation)
6. **Report** results and move to next feature

**Use this workflow for every feature** and you'll maintain:
- ✅ Clean architecture
- ✅ CTO requirement compliance
- ✅ Production-ready code
- ✅ Efficient development
- ✅ Team alignment

---

## Contact & Questions

If you're unsure about any part of this process:
1. **Brainstorming**: Ask "Should I approach this as X or Y?"
2. **Finalization**: Ask "Is this design complete?"
3. **Code Generation**: Ask "Ready to code?" (or similar signal)
4. **Implementation**: Ask "What do I do with this error?"
5. **Integration**: Ask "Where does this file go?"

The workflow is flexible but **the phases are mandatory** for best results.

---

**Happy coding! 🚀**
