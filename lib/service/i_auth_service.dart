import 'package:http/http.dart' as http;

abstract class IAuthService {
  Future<http.BaseClient> createClient();

  Future<bool> isAuthenticated();

  Future<void> logout();
}
