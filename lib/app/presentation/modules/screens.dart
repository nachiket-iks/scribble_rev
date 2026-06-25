import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:scribble/app/core/constants/app_constants.dart';
import 'package:scribble/app/presentation/modules/recording/recording_controller.dart';

import '../../services/app_services.dart';

/// Login Screen (non-functional in v1)
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Login'),
        ),
        child: Center(
          child: CupertinoButton.filled(
            child: const Text('Continue'),
            onPressed: () => context.go('/home'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go('/home'),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}

/// Home Screen - mode selection
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Home'),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Start Recording',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                _buildIOSModeButton(
                  context,
                  'Live Chunk Mode',
                  'Encrypt and upload while recording',
                  RecordingMode.liveChunk,
                ),
                const SizedBox(height: 16),
                _buildIOSModeButton(
                  context,
                  'Record Full Mode',
                  'Record complete, then encrypt and upload',
                  RecordingMode.recordFull,
                ),
                const SizedBox(height: 32),
                CupertinoButton(
                  onPressed: () => context.push('/library'),
                  child: const Text('View Library'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Start Recording',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _buildMaterialModeCard(
                context,
                'Live Chunk Mode',
                'Encrypt and upload while recording',
                RecordingMode.liveChunk,
              ),
              const SizedBox(height: 16),
              _buildMaterialModeCard(
                context,
                'Record Full Mode',
                'Record complete, then encrypt and upload',
                RecordingMode.recordFull,
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () => context.push('/library'),
                child: const Text('View Library'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIOSModeButton(
    BuildContext context,
    String title,
    String subtitle,
    RecordingMode mode,
  ) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => context.push('/recording/${mode.name}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.label,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialModeCard(
    BuildContext context,
    String title,
    String subtitle,
    RecordingMode mode,
  ) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/recording/${mode.name}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Recording Screen
class RecordingScreen extends StatefulWidget {
  final String modeName;

  const RecordingScreen({
    super.key,
    required this.modeName,
  });

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  late final RecordingController _controller;
  late final RecordingMode _mode;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<RecordingController>();
    _mode = RecordingMode.values.firstWhere(
      (m) => m.name == widget.modeName,
      orElse: () => RecordingMode.recordFull,
    );

    ever(_controller.snackbarMessage, (msg) {
      if (msg != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${msg.title}: ${msg.message}')),
        );
        _controller.snackbarMessage.value = null;
      }
    });

    ever(_controller.shouldNavigateBack, (should) {
      if (should && mounted) {
        _controller.shouldNavigateBack.value = false;
        context.go('/home');
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.currentRecording.value == null) {
        _controller.startRecording(
          title: 'Recording ${DateTime.now()}',
          mode: _mode,
          clientCode: 'test_client',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(_mode.displayName),
        ),
        child: SafeArea(
          child: Obx(() => _buildRecordingContent(_controller, isIOS)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_mode.displayName)),
      body: SafeArea(
        child: Obx(() => _buildRecordingContent(_controller, isIOS)),
      ),
    );
  }

  Widget _buildRecordingContent(RecordingController controller, bool isIOS) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Recording indicator
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.currentRecording.value != null
                  ? (isIOS ? CupertinoColors.systemRed : Colors.red)
                  : (isIOS ? CupertinoColors.systemGrey : Colors.grey),
            ),
            child: const Icon(
              Icons.mic,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),

          // Duration display
          Text(
            Get.find<AudioService>().recordingDuration.toString().split('.').first,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Status
          Text(
            controller.currentRecording.value?.status.name ?? 'Idle',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 48),

          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.currentRecording.value != null) ...[
                if (isIOS)
                  CupertinoButton.filled(
                    onPressed: controller.pauseRecording,
                    child: const Text('Pause'),
                  )
                else
                  FilledButton(
                    onPressed: controller.pauseRecording,
                    child: const Text('Pause'),
                  ),
                const SizedBox(width: 16),
                if (isIOS)
                  CupertinoButton(
                    color: CupertinoColors.destructiveRed,
                    onPressed: controller.stopRecording,
                    child: const Text('Stop'),
                  )
                else
                  FilledButton(
                    onPressed: controller.stopRecording,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Stop'),
                  ),
              ],
            ],
          ),
          const SizedBox(height: 32),

          // Paused sessions
          if (controller.pausedRecordings.isNotEmpty) ...[
            const Text(
              'Paused Sessions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...controller.pausedRecordings.map(
              (recording) => ListTile(
                title: Text(recording.title),
                subtitle: Text(recording.formattedDuration),
                trailing: isIOS
                    ? CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Text('Resume'),
                        onPressed: () => controller.resumeRecording(recording),
                      )
                    : TextButton(
                        onPressed: () => controller.resumeRecording(recording),
                        child: const Text('Resume'),
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Library Screen - placeholder
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Library'),
        ),
        child: Center(
          child: Text('Recordings will appear here'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: const Center(
        child: Text('Recordings will appear here'),
      ),
    );
  }
}
