abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ClientException extends AppException {
  ClientException(super.message);
}

class LocalStorageException extends AppException {
  LocalStorageException(super.message);
}
