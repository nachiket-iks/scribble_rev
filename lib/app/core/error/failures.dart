/// Base class for all failures in the domain layer
abstract class Failure {
  final String message;
  final String? code;
  final dynamic originalError;
  
  const Failure({
    required this.message,
    this.code,
    this.originalError,
  });
  
  @override
  String toString() => 'Failure: $message ${code != null ? "($code)" : ""}';
}

/// Database operation failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// File system operation failures
class FileSystemFailure extends Failure {
  const FileSystemFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Audio recording/playback failures
class AudioFailure extends Failure {
  const AudioFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Encryption/decryption failures
class CryptoFailure extends Failure {
  const CryptoFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Network/upload failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Unknown/unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}
