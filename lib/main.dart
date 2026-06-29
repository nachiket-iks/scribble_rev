import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scribble/app/routes/app_router.dart';

import 'app/services/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await initializeDependencies();

  runApp(const ScribbleApp());
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
