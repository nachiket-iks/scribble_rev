import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
