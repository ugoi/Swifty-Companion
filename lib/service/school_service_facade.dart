import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/dtos/user_dto.dart';
import 'package:swifty_companion/service/i_auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/service/school_data_service.dart';

class SchoolServiceFacade {
  final IAuthService _authService;
  SchoolDataService? _schoolDataService;

  SchoolServiceFacade({required IAuthService clientManager})
      : _authService = clientManager;

  Future<void> init() async {
    if (await isAuthenticated()) {
      http.BaseClient client = await _authService.createClient();
      _schoolDataService = SchoolDataService(client: client);
    }
  }

  Future<void> loginWith42() async {
    http.BaseClient client = await _authService.createClient();
    _schoolDataService = SchoolDataService(client: client);
    return;
  }

  Future<bool> isAuthenticated() async {
    return _authService.isAuthenticated();
  }

  Future<void> logout() async {
    return _authService.logout();
  }

  Future<UserDto> getUser(String id) async {
    if (_schoolDataService == null) {
      throw Exception("Not logged in");
    }
    return _schoolDataService!.getUser(id);
  }

  Future<List<SearchUserDto>> searchUsers(String query) async {
    if (_schoolDataService == null) {
      throw Exception("Not logged in");
    }
    return _schoolDataService!.searchUsers(query);
  }

  Future<List<SearchUserDto>> getAllSearchUsers() async {
    return _schoolDataService!.getAllSearchUsers();
  }
}
