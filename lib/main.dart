import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scribble/app/routes/app_router.dart';
import 'package:scribble/app/data/database/database.dart';
import 'package:scribble/app/data/repositories/recording_repository_impl.dart';
import 'package:scribble/app/data/repositories/repositories_impl.dart';
import 'package:scribble/app/data/datasources/sink/v1_stubs.dart';
import 'package:scribble/app/domain/repositories/recording_repository.dart';
import 'package:scribble/app/domain/repositories/chunk_repository.dart';
import 'package:scribble/app/domain/repositories/queue_repository.dart';
import 'package:scribble/app/domain/usecases/start_recording.dart';
import 'package:scribble/app/domain/usecases/recording_usecases.dart';
import 'package:scribble/app/domain/interfaces/v2_boundaries.dart';
import 'package:scribble/app/services/app_services.dart';
import 'package:scribble/app/presentation/modules/recording/recording_controller.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await _initializeDependencies();
  
  runApp(const ScribbleApp());
}

/// Initialize all dependencies
Future<void> _initializeDependencies() async {
  // Database
  final database = AppDatabase();
  Get.put<AppDatabase>(database, permanent: true);
  
  // V1 Stubs
  Get.put<UploadSink>(MockUploadSink(), permanent: true);
  Get.put<KeyProvider>(LocalTestKeyProvider(), permanent: true);
  Get.put<ConfigSource>(StaticConfigSource(), permanent: true);
  Get.put<AuthGate>(NoOpAuthGate(), permanent: true);
  Get.put<Telemetry>(ConsoleTelemetry(), permanent: true);
  Get.put<AppointmentSource>(SeedAppointmentSource(), permanent: true);
  
  // Repositories
  Get.put<RecordingRepository>(
    RecordingRepositoryImpl(database: database),
    permanent: true,
  );
  Get.put<ChunkRepository>(
    ChunkRepositoryImpl(database: database),
    permanent: true,
  );
  Get.put<QueueRepository>(
    QueueRepositoryImpl(database: database),
    permanent: true,
  );
  
  // Services
  Get.put<AudioService>(AudioService(), permanent: true);
  Get.put<CryptoService>(
    CryptoService(keyProvider: Get.find<KeyProvider>()),
    permanent: true,
  );
  Get.put<QueueService>(
    QueueService(
      chunkRepository: Get.find<ChunkRepository>(),
      uploadSink: Get.find<UploadSink>(),
    ),
    permanent: true,
  );
  
  // Use cases
  Get.put<StartRecordingUseCase>(
    StartRecordingUseCase(repository: Get.find<RecordingRepository>()),
    permanent: true,
  );
  Get.put<PauseRecordingUseCase>(
    PauseRecordingUseCase(repository: Get.find<RecordingRepository>()),
    permanent: true,
  );
  Get.put<ResumeRecordingUseCase>(
    ResumeRecordingUseCase(repository: Get.find<RecordingRepository>()),
    permanent: true,
  );
  Get.put<StopRecordingUseCase>(
    StopRecordingUseCase(repository: Get.find<RecordingRepository>()),
    permanent: true,
  );
  
  // Controllers
  Get.put<RecordingController>(
    RecordingController(
      recordingRepository: Get.find<RecordingRepository>(),
      audioService: Get.find<AudioService>(),
      startRecording: Get.find<StartRecordingUseCase>(),
      pauseRecording: Get.find<PauseRecordingUseCase>(),
      resumeRecording: Get.find<ResumeRecordingUseCase>(),
      stopRecording: Get.find<StopRecordingUseCase>(),
    ),
    permanent: true,
  );
  
  // Start queue processing
  Get.find<QueueService>().startProcessing();
}

/// Main application widget
/// 
/// Uses standard Flutter apps (MaterialApp.router / CupertinoApp.router)
/// instead of GetX variants to maintain separation of concerns:
/// - Navigation: GoRouter (independent)
/// - State Management: GetX (only in presentation layer)
/// - Domain: Pure Dart (framework-agnostic)
/// 
/// This architecture makes future migration to BLoC much easier:
/// - Only controllers and screens need to change
/// - Routes, navigation, domain layer remain untouched
class ScribbleApp extends StatelessWidget {
  const ScribbleApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    
    if (isIOS) {
      // Standard CupertinoApp.router (NOT GetCupertinoApp.router)
      // This keeps routing independent from state management
      return CupertinoApp.router(
        title: 'Scribble',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
          brightness: Brightness.light,
        ),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      );
    }
    
    // Standard MaterialApp.router (NOT GetMaterialApp.router)
    // This keeps routing independent from state management
    return MaterialApp.router(
      title: 'Scribble',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
