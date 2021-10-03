class ServerException implements Exception {
  final String errorText;
  ServerException({required this.errorText});
}

class ConnectionRefused implements ServerException {
  final String errorText;
  ConnectionRefused({required this.errorText});
}

class ConnectionTimeOut implements ServerException {
  final String errorText;
  ConnectionTimeOut({required this.errorText});
}

class LocalCacheException implements Exception {
  final String errorText;
  LocalCacheException({required this.errorText});
}

class Failure implements Exception {
  Failure({this.errorText});
  final String? errorText;
}

class ServerFailure extends Failure {
  ServerFailure({String? errorText}) : super(errorText: errorText);
}

class LocalFailure extends Failure {
  LocalFailure({String? errorText}) : super(errorText: errorText);
}
