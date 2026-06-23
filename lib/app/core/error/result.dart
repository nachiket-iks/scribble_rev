import 'failures.dart';

/// Result type for functional error handling
/// Represents either a Success with data or a Failure
sealed class Result<T> {
  const Result();
  
  /// Create a successful result
  factory Result.success(T data) = Success<T>;
  
  /// Create a failed result
  factory Result.failure(Failure failure) = Failed<T>;
  
  /// Check if result is successful
  bool get isSuccess => this is Success<T>;
  
  /// Check if result is failed
  bool get isFailure => this is Failed<T>;
  
  /// Get data if success, null otherwise
  T? get dataOrNull => isSuccess ? (this as Success<T>).data : null;
  
  /// Get failure if failed, null otherwise
  Failure? get failureOrNull => isFailure ? (this as Failed<T>).failure : null;
  
  /// Fold the result into a single value
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    return switch (this) {
      Success(data: final data) => onSuccess(data),
      Failed(failure: final failure) => onFailure(failure),
    };
  }
  
  /// Map the success value
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final data) => Result.success(transform(data)),
      Failed(failure: final failure) => Result.failure(failure),
    };
  }
  
  /// FlatMap (chain) another result-producing operation
  Result<R> flatMap<R>(Result<R> Function(T data) transform) {
    return switch (this) {
      Success(data: final data) => transform(data),
      Failed(failure: final failure) => Result.failure(failure),
    };
  }
  
  /// Get data or throw exception
  T getOrThrow() {
    return switch (this) {
      Success(data: final data) => data,
      Failed(failure: final failure) => throw Exception(failure.message),
    };
  }
  
  /// Get data or return default value
  T getOrElse(T defaultValue) {
    return switch (this) {
      Success(data: final data) => data,
      Failed() => defaultValue,
    };
  }
}

/// Success case of Result
final class Success<T> extends Result<T> {
  final T data;
  
  const Success(this.data);
  
  @override
  String toString() => 'Success($data)';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> && runtimeType == other.runtimeType && data == other.data;
  
  @override
  int get hashCode => data.hashCode;
}

/// Failure case of Result
final class Failed<T> extends Result<T> {
  final Failure failure;
  
  const Failed(this.failure);
  
  @override
  String toString() => 'Failed($failure)';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failed<T> && runtimeType == other.runtimeType && failure == other.failure;
  
  @override
  int get hashCode => failure.hashCode;
}

/// Extension methods for Future<Result<T>>
extension ResultFutureExtensions<T> on Future<Result<T>> {
  /// Handle the result asynchronously
  Future<R> fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) async {
    final result = await this;
    return result.fold(
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
  }
  
  /// Map the success value asynchronously
  Future<Result<R>> map<R>(R Function(T data) transform) async {
    final result = await this;
    return result.map(transform);
  }
  
  /// FlatMap asynchronously
  Future<Result<R>> flatMap<R>(Future<Result<R>> Function(T data) transform) async {
    final result = await this;
    return switch (result) {
      Success(data: final data) => await transform(data),
      Failed(failure: final failure) => Result.failure(failure),
    };
  }
}
