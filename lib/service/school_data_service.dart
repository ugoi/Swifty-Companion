import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/dtos/user_dto.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_image.dart';

class SchoolDataService {
  final http.BaseClient _client;

  SchoolDataService({required http.BaseClient client}) : _client = client;

  Future<UserDto> getUser(String id) async {
    final response = await _client.get(
        Uri(scheme: 'https', host: 'api.intra.42.fr', path: '/v2/users/$id'));

    return userDtoFromJson(response.body);
  }

  Future<List<SearchUser>> searchUsers(
    String query,
  ) async {
    List<SearchUserDto> searchUserDtos;
    final response = await _client.get(Uri(
        scheme: 'https',
        host: 'api.intra.42.fr',
        path: '/v2/users',
        queryParameters: {'filter[login]': query, 'filter[kind]': 'student'}));

    searchUserDtos = searchUserDtoFromJson(response.body);

    return searchUserDtos
        .map((e) => SearchUser(
            id: e.id.toString(),
            login: e.login,
            profilePicture: UserImage(
                url: e.image?.link,
                versions: ImageVersions(
                    large: e.image?.versions?.large,
                    medium: e.image?.versions?.medium,
                    micro: e.image?.versions?.micro,
                    small: e.image?.versions?.small))))
        .toList();
  }
}
