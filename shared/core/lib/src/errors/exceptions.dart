import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final dynamic details;

  const CustomException(
    this.message, {
    this.code,
    this.statusCode,
    this.details,
  });

  @override
  List<Object?> get props => [message, code, statusCode, details];
}

class NetworkException extends CustomException {
  const NetworkException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class ServerException extends CustomException {
  const ServerException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class TimeoutException extends CustomException {
  const TimeoutException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class CacheException extends CustomException {
  const CacheException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class ValidationException extends CustomException {
  const ValidationException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class AuthenticationException extends CustomException {
  const AuthenticationException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class AuthorizationException extends CustomException {
  const AuthorizationException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class NotFoundException extends CustomException {
  const NotFoundException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}

class UnknownException extends CustomException {
  const UnknownException(
    super.message, {
    super.code,
    super.statusCode,
    super.details,
  });
}