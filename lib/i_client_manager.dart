import 'package:http/http.dart' as http;

abstract class IClientManager {
  Future<http.BaseClient> createClient();
}
