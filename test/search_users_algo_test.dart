import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swifty_companion/algo/searchUsersAlgo.dart';
import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/service/i_auth_service.dart';
import 'package:swifty_companion/service/school_data_service.dart';
import 'package:swifty_companion/logging_setup.dart';
import 'package:http/http.dart' as http;

void main() {
  late SearchUsersAlgo searchUsersAlgo;

  setUp(() {
    searchUsersAlgo = SearchUsersAlgo();
  });

  setUpAll(() {
    setupLogging();
    registerFallbackValue(Uri());
  });

  group('SearchAlgo', () {
    test('returns correct search result', () async {
      final file = File('test/data/all_search_users.json');

      final List<SearchUserDto> searchUserDtos =
          searchUserDtoFromJson(await file.readAsString());

      final searchUsers =
          await searchUsersAlgo.searchUsers('yulpark', searchUserDtos);

      final searchUsersMultiple =
          await searchUsersAlgo.searchUsers('dn', searchUserDtos);

      expect(searchUsers[0].login, 'yulpark');
      expect(searchUsersMultiple.length, 3);
      expect(searchUsersMultiple.map((user) => user.login).toList(),
          containsAll(['dnixdorf', 'dna', 'adnixdorf']));
      expect(searchUsersMultiple.map((user) => user.login).toList()[2],
          'adnixdorf');
    });
  });
}
