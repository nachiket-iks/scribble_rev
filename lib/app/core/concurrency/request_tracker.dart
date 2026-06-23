import 'package:dio/dio.dart';

/// Service for tracking and cancelling duplicate API requests
/// 
/// Prevents duplicate requests by cancelling previous requests with the same ID
/// before initiating a new one. Essential for button mashing protection and
/// screen lifecycle management.
class RequestTracker {
  final Map<String, CancelToken> _activeRequests = {};
  
  /// Track a new request and cancel any existing request with the same ID
  /// 
  /// Usage:
  /// ```dart
  /// final token = requestTracker.trackRequest('upload_chunk_123');
  /// await dio.post('/upload', cancelToken: token);
  /// requestTracker.completeRequest('upload_chunk_123');
  /// ```
  CancelToken trackRequest(String requestId) {
    // Cancel existing request if any
    final existingToken = _activeRequests[requestId];
    if (existingToken != null && !existingToken.isCancelled) {
      existingToken.cancel('New request initiated for $requestId');
    }
    
    // Create and track new token
    final token = CancelToken();
    _activeRequests[requestId] = token;
    
    return token;
  }
  
  /// Mark request as complete and remove from tracking
  void completeRequest(String requestId) {
    _activeRequests.remove(requestId);
  }
  
  /// Cancel a specific request by ID
  void cancelRequest(String requestId, [String reason = 'Request cancelled']) {
    final token = _activeRequests[requestId];
    if (token != null && !token.isCancelled) {
      token.cancel(reason);
    }
    _activeRequests.remove(requestId);
  }
  
  /// Cancel all active requests
  void cancelAll([String reason = 'All requests cancelled']) {
    for (final entry in _activeRequests.entries) {
      if (!entry.value.isCancelled) {
        entry.value.cancel(reason);
      }
    }
    _activeRequests.clear();
  }
  
  /// Check if a request is currently active
  bool isRequestActive(String requestId) {
    final token = _activeRequests[requestId];
    return token != null && !token.isCancelled;
  }
  
  /// Get count of active requests
  int get activeRequestCount => _activeRequests.length;
  
  /// Clear all tracking (for cleanup)
  void dispose() {
    cancelAll('RequestTracker disposed');
  }
}
