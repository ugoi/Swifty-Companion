import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/dtos/user_dto.dart';
import 'package:http/http.dart' as http;

class SchoolDataService {
  final http.BaseClient _client;

  SchoolDataService({required http.BaseClient client}) : _client = client;

  Future<UserDto> getUser(String id) async {
    final response = await _client.get(Uri(
        scheme: 'https', host: 'api.intra.42.fr', path: '/v2/users/133113'));

    return userDtoFromJson(response.body);
  }

  Future<List<SearchUserDto>> searchUsers(String query) async {
    final response = await _client.get(Uri(
        scheme: 'https',
        host: 'api.intra.42.fr',
        path: '/v2/users',
        queryParameters: {'filter[login]': query, 'filter[kind]': 'student'}));

    return searchUserDtoFromJson(response.body);
  }

  Future<List<SearchUserDto>> getAllSearchUsers() async {
    return [SearchUserDto()];
  }
}
