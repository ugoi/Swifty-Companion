import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/dtos/user_dto.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_image.dart';
import 'package:swifty_companion/environment.dart';

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
    List<SearchUser> searchUsers = [];
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

  Future<List<SearchUserDto>> _getAllSearchUsers(String query) async {
    // final file = File('assets/all_search_users.json');

    final credentialsFilePath = await Environment.searchUsersFilePath;

    final searchUsersFile = const LocalFileSystem().file(credentialsFilePath);
    var exists = await searchUsersFile.exists();

    if (!exists) {
      String fileString =
          await rootBundle.loadString('assets/all_search_users.json');
      await searchUsersFile.writeAsString(fileString);
    }

    // final response = await _client.get(Uri(
    //     scheme: 'https',
    //     host: 'api.intra.42.fr',
    //     path: '/v2/users',
    //     queryParameters: {'filter[login]': query, 'filter[kind]': 'student'}));

    final response = await searchUsersFile.readAsString();

    return searchUserDtoFromJson(response);
  }

  // bool _containsQuery(String query, String? other) {
  //   return other?.toLowerCase().contains(query.toLowerCase()) ?? false;
  // }
}
