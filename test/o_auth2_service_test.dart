import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swifty_companion/o_auth2_service.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late OAuth2Service oAuth2ClientManager;
  late MockHttpClient mockHttpClient;
  const String credentialsFilePath = '/credentials.json';
  late MemoryFileSystem memoryFileSystem;

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  setUp(() {
    memoryFileSystem = MemoryFileSystem();
    mockHttpClient = MockHttpClient();
    oAuth2ClientManager = OAuth2Service(
        redirect: (Uri uri) => Future<void>.value(),
        listen: (Uri uri) => Future<Uri>.value(Uri.parse(
            "https://example.com/oauth2/callback?code=AUTHORIZATION_CODE&state=STATE")),
        fileSystem: memoryFileSystem,
        authorizationEndpoint: "http://example.com/oauth2/authorization",
        tokenEndpoint: 'http://example.com/oauth2/token',
        identifier: 'my client identifier',
        secret: 'my client secret',
        redirectUrl: 'http://my-site.com/oauth2-redirect',
        credentialsFilePath: credentialsFilePath,
        httpClient: mockHttpClient);
  });

  group('OAuth2Service', () {
    test('creates client', () async {
      http.Client client =
          await createMockClient(mockHttpClient, oAuth2ClientManager);

      final credentialsFile = memoryFileSystem.file(credentialsFilePath);

      var exists = await credentialsFile.exists();

      expect(exists, isTrue);

      expect(client, isA<http.Client>());
    });

    test('throws error', () async {
      final responseHeaders = {'content-type': 'application/json'};
      const responseBody = '{"error": "invalid_request"}';

      http.Response response =
          http.Response(responseBody, 400, headers: responseHeaders);

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => response);

      // final client = await oAuth2ClientManager.createClient();

      expect(() async => await oAuth2ClientManager.createClient(),
          throwsException);
    });

    test('isAuthenticated returns correct value', () async {
      expect(await oAuth2ClientManager.isAuthenticated(), false);

      await createMockClient(mockHttpClient, oAuth2ClientManager);

      expect(await oAuth2ClientManager.isAuthenticated(), true);
    });

    test('logout()', () async {
      await createMockClient(mockHttpClient, oAuth2ClientManager);

      oAuth2ClientManager.logout();

      expect(await oAuth2ClientManager.isAuthenticated(), false);
    });
  });
}

Future<http.Client> createMockClient(
    MockHttpClient mockHttpClient, OAuth2Service oAuth2ClientManager) async {
  final responseHeaders = {'content-type': 'application/json'};
  const responseBody =
      '{"access_token": "ACCESS_TOKEN_VALUE", "token_type": "bearer", "expires_in": 3600, "refresh_token": "REFRESH_TOKEN_VALUE"}';

  http.Response response =
      http.Response(responseBody, 200, headers: responseHeaders);

  when(() => mockHttpClient.post(any(),
      headers: any(named: 'headers'),
      body: any(named: 'body'))).thenAnswer((_) async => response);
  final http.Client client = await oAuth2ClientManager.createClient();
  return client;
}
