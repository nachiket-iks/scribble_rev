import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scribble/app/presentation/modules/screens.dart';

/// Application routes configuration
class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String recording = '/recording/:mode';
  static const String library = '/library';
  static const String playback = '/playback/:id';
}

/// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.recording,
      builder: (context, state) {
        final mode = state.pathParameters['mode']!;
        return RecordingScreen(modeName: mode);
      },
    ),
    GoRoute(
      path: AppRoutes.library,
      builder: (context, state) => const LibraryScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Text('Page not found: ${state.matchedLocation}'),
    ),
  ),
);
