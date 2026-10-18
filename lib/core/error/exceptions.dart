sealed class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;
}

final class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

final class CacheException extends AppException {
  const CacheException(super.message);
}

final class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized'])
    : super(statusCode: 401);
}
