class RegisterException implements Exception {}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class LoginException implements Exception {}

class LogoutException implements Exception {}

class CheckAuthenticationException implements Exception {}
