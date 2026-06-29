import 'package:get/get.dart';
import 'package:scribble/app/data/datasources/sink/v1_stubs.dart';
import 'package:scribble/app/data/repositories/recording_repository_impl.dart';
import 'package:scribble/app/data/repositories/repositories_impl.dart';
import 'package:scribble/app/domain/interfaces/v2_boundaries.dart';
import 'package:scribble/app/domain/repositories/chunk_repository.dart';
import 'package:scribble/app/domain/repositories/queue_repository.dart';
import 'package:scribble/app/domain/repositories/recording_repository.dart';
import 'package:scribble/app/domain/usecases/recording_usecases.dart';
import 'package:scribble/app/domain/usecases/start_recording.dart';
import 'package:scribble/app/presentation/modules/recording/recording_controller.dart';
import 'package:scribble/app/services/app_services.dart';

import '../data/database/database.dart';

/// Initialize all dependencies
Future<void> initializeDependencies() async {
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
