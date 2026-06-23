import 'dart:async';
import 'package:get/get.dart';

/// Mixin for automatic disposal of streams and subscriptions
mixin DisposableMixin on GetxController {
  final List<StreamSubscription> _subscriptions = [];
  final List<StreamController> _controllers = [];
  
  /// Add a subscription to be automatically disposed
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
  
  /// Add a stream controller to be automatically disposed
  void addController(StreamController controller) {
    _controllers.add(controller);
  }
  
  /// Create and track a stream subscription
  StreamSubscription<T> listen<T>(
    Stream<T> stream,
    void Function(T event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final subscription = stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
    addSubscription(subscription);
    return subscription;
  }
  
  @override
  void onClose() {
    // Cancel all subscriptions
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    
    // Close all controllers
    for (final controller in _controllers) {
      controller.close();
    }
    _controllers.clear();
    
    super.onClose();
  }
}

/// Mixin for logging capabilities
mixin LoggerMixin {
  String get logTag => runtimeType.toString();
  
  /// Log debug message
  void logDebug(String message) {
    print('[$logTag] DEBUG: $message');
  }
  
  /// Log info message
  void logInfo(String message) {
    print('[$logTag] INFO: $message');
  }
  
  /// Log warning message
  void logWarning(String message) {
    print('[$logTag] WARNING: $message');
  }
  
  /// Log error message
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    print('[$logTag] ERROR: $message');
    if (error != null) {
      print('[$logTag] Error details: $error');
    }
    if (stackTrace != null) {
      print('[$logTag] Stack trace:\n$stackTrace');
    }
  }
}

/// Mixin for lifecycle awareness (background/foreground)
mixin LifecycleAwareMixin on GetxController {
  /// Called when app enters foreground
  void onForeground() {
    // Override in subclasses
  }
  
  /// Called when app enters background
  void onBackground() {
    // Override in subclasses
  }
  
  /// Called when device is locked
  void onDeviceLocked() {
    // Override in subclasses
  }
  
  /// Called when device is unlocked
  void onDeviceUnlocked() {
    // Override in subclasses
  }
}

/// Mixin for reactive state management
mixin ReactiveStateMixin on GetxController {
  final _isLoading = false.obs;
  final _error = Rx<String?>(null);
  
  /// Whether the controller is currently loading
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  
  /// Current error message, if any
  String? get error => _error.value;
  set error(String? value) => _error.value = value;
  
  /// Clear error state
  void clearError() => error = null;
  
  /// Execute an async operation with loading and error handling
  Future<T?> executeAsync<T>(
    Future<T> Function() operation, {
    String? errorMessage,
    void Function(T result)? onSuccess,
    void Function(dynamic error)? onError,
  }) async {
    try {
      isLoading = true;
      clearError();
      
      final result = await operation();
      
      if (onSuccess != null) {
        onSuccess(result);
      }
      
      return result;
    } catch (e) {
      error = errorMessage ?? e.toString();
      
      if (onError != null) {
        onError(e);
      }
      
      return null;
    } finally {
      isLoading = false;
    }
  }
}
