import 'package:fpdart/fpdart.dart';

import '../utils/typedefs.dart';
import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  const ErrorHandler();

  Failure toFailure(Object error) => switch (error) {
    ServerException e => ServerFailure(e.message, statusCode: e.statusCode),
    CacheException e => CacheFailure(e.message),
    NetworkException e => NetworkFailure(e.message),
    UnauthorizedException e => UnauthorizedFailure(
      e.message,
      statusCode: e.statusCode,
    ),
    FormatException e => UnexpectedFailure('Invalid data format: ${e.message}'),
    _ => UnexpectedFailure(error.toString()),
  };

  ResultFuture<T> guard<T>(Future<T> Function() action) =>
      TaskEither<Failure, T>.tryCatch(action, (e, _) => toFailure(e)).run();
}
