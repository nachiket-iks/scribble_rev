import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scribble/app/core/constants/app_constants.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
        child: Container(
          width: MediaQuery.of(context).size.width,
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
