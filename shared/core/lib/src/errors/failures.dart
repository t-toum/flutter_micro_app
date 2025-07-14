import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic details;
  const Failure(this.message, {this.code, this.details});
  @override
  List<Object?> get props => [message, code, details];

  String get getMessage => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code, super.details});

  @override
  String get getMessage =>
      "Network connection error. Please check your internet connection.";
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => "Server error. Please try again later.";
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => "Request timed out. Please try again.";
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => "Local data error. Please refresh the data.";
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => message;
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => 'Authentication failed. Please login again.';
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => 'You don\'t have permission to perform this action.';
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => 'Requested data not found.';
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.code, super.details});

  @override
  String get getMessage => 'An unexpected error occurred. Please try again.';
}