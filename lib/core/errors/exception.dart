class CacheException implements Exception {}

class ServerException implements Exception {
  final String? message;

  ServerException({this.message});

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class SystemException implements Exception {
  final String? message;

  SystemException({this.message});

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
