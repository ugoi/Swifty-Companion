import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swifty_companion/algo/searchUsersAlgo.dart';
import 'package:swifty_companion/service/i_auth_service.dart';
import 'package:swifty_companion/service/school_data_service.dart';
import 'package:swifty_companion/logging_setup.dart';
import 'package:http/http.dart' as http;

class MockClientManager extends Mock implements IAuthService {}

class MockBaseClient extends Mock implements http.BaseClient {}

void main() {
  late SchoolDataService schoolService;
  late MockBaseClient mockBaseClient;

  setUp(() {
    mockBaseClient = MockBaseClient();
    schoolService = SchoolDataService(
        client: mockBaseClient, searchUsersAlgo: SearchUsersAlgo());
  });

  setUpAll(() {
    setupLogging();
    registerFallbackValue(Uri());
  });

  group('SchoolDataService', () {
    group('search users', () {
      test('calls 42 api and returns json', () async {
        final file = File('test/data/search_user.json');
        final json = jsonDecode(await file.readAsString());
        final String query = "sdukic";

        when(() => mockBaseClient.get(any())).thenAnswer(
            (invocation) async => http.Response(jsonEncode(json), 200));

        final users = await schoolService.searchUsers(query);

        expect(users[0].id, 133113);
        expect(users[0].login, "sdukic");
      });
    });

    // group('searchUsersLocally', () {
    //   test('returns correct search result', () async {
    //     final file = File('test/data/all_search_users.json');
    //     final json = jsonDecode(await file.readAsString());

    //     when(() => mockBaseClient.get(any())).thenAnswer(
    //         (invocation) async => http.Response(jsonEncode(json), 200));

    //     final searchUsers =
    //         await schoolService.searchUsers('yulpark');

    //     final searchUsersMultiple =
    //         await schoolService.searchUsers('dn');

    //     expect(searchUsers[0].login, 'yulpark');
    //     expect(searchUsersMultiple.length, 2);
    //     expect(searchUsersMultiple.map((user) => user.login).toList(),
    //         containsAll(['dnixdorf', 'dna']));
    //   });
    // });

    group('get user', () {
      test('calls 42 api and returns json', () async {
        final file = File('test/data/user.json');
        final json = jsonDecode(await file.readAsString());

        when(() => mockBaseClient.get(Uri(
                scheme: 'https',
                host: 'api.intra.42.fr',
                path: '/v2/users/133113')))
            .thenAnswer(
                (invocation) async => http.Response(jsonEncode(json), 200));

        final user = await schoolService.getUser('133113');

        expect(user.id, 133113);
        expect(user.login, "sdukic");
        expect(user.cursusUsers?[1].level, 13.28);
      });
    });
  });
}
