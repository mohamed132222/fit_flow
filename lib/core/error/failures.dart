import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message, {super.statusCode});
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
