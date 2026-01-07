import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class UnknownFailure extends Failure {
  const UnknownFailure(this.message);
  final String? message;

  @override
  List<Object?> get props => [message];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  List<Object?> get props => [];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure();

  @override
  List<Object?> get props => [];
}
