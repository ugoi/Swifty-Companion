import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:swifty_companion/algo/searchUsersAlgo.dart';
import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/dtos/user_dto.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/environment.dart';

class SchoolDataService {
  final http.BaseClient _client;
  final SearchUsersAlgo _searchUsersAlgo;

  SchoolDataService(
      {required http.BaseClient client,
      required SearchUsersAlgo searchUsersAlgo})
      : _client = client,
        _searchUsersAlgo = searchUsersAlgo;

  Future<UserDto> getUser(String id) async {
    final response = await _client.get(Uri(
        scheme: 'https', host: 'api.intra.42.fr', path: '/v2/users/$id'));

    return userDtoFromJson(response.body);
  }

  // Future<List<SearchUserDto>> searchUsers(String query) async {
  //   final response = await _client.get(Uri(
  //       scheme: 'https',
  //       host: 'api.intra.42.fr',
  //       path: '/v2/users',
  //       queryParameters: {'filter[login]': query, 'filter[kind]': 'student'}));

  //   return searchUserDtoFromJson(response.body);
  // }

  Future<List<SearchUserDto>> searchUsers(String query,
      [bool searchLocally = false]) async {
    List<SearchUserDto> searchUserDtos;
    if (searchLocally) {
      searchUserDtos = (await _getAllSearchUsers(query));
      searchUserDtos =
          await _searchUsersAlgo.searchUsers(query, searchUserDtos);
    } else {
      final response = await _client.get(Uri(
          scheme: 'https',
          host: 'api.intra.42.fr',
          path: '/v2/users',
          queryParameters: {
            'filter[login]': query,
            'filter[kind]': 'student'
          }));

      searchUserDtos = searchUserDtoFromJson(response.body);
    }

    //     .where((e) =>
    //         (_containsQuery(query, e.login)) ||
    //         (_containsQuery(query, e.displayname)))
    //     .toList();

    // searchUserDtos
    //   .sort((a, b) {
    //     int indexA1 = a.login.toLowerCase().indexOf('st');
    //     int indexA2 = a.displayname.toLowerCase().indexOf('st');
    //     int indexA = [indexA1, indexA2].reduce(min);

    //     int indexB1 = b.login.toLowerCase().indexOf('st');
    //     int indexB2 = b.displayname.toLowerCase().indexOf('st');
    //     int indexB = [indexB1, indexB2].reduce(min);

    //     if (indexA == -1 && indexB == -1) {
    //       return 0;
    //     } else if (indexA == -1) {
    //       return 1;
    //     } else if (indexB == -1) {
    //       return -1;
    //     } else {
    //       return indexA.compareTo(indexB);
    //     }
    //   });

    return searchUserDtos;
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
