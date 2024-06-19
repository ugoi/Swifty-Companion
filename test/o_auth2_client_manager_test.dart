import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swifty_companion/o_auth2_client_manager.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late OAuth2ClientManager oAuth2ClientManager;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse(''));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    oAuth2ClientManager = OAuth2ClientManager(
        redirect: (Uri uri) => Future<void>.value(),
        listen: (Uri uri) => Future<Uri>.value(Uri.parse(
            "https://example.com/oauth2/callback?code=AUTHORIZATION_CODE&state=STATE")),
        fileSystem: MemoryFileSystem(),
        authorizationEndpoint: "http://example.com/oauth2/authorization",
        tokenEndpoint: 'http://example.com/oauth2/token',
        identifier: 'my client identifier',
        secret: 'my client secret',
        redirectUrl: 'http://my-site.com/oauth2-redirect',
        credentialsFilePath: '~/.myapp/credentials.json',
        httpClient: mockHttpClient);
  });

  group('OAuth2ClientManager', () {
    test('creates client', () async {
      final responseHeaders = {'content-type': 'application/json'};
      final responseBody =
          '{"access_token": "ACCESS_TOKEN_VALUE", "token_type": "bearer", "expires_in": 3600, "refresh_token": "REFRESH_TOKEN_VALUE"}';

      http.Response response =
          http.Response(responseBody, 200, headers: responseHeaders);

      when(() => mockHttpClient.post(any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'))).thenAnswer((_) async => response);
      final http.Client client = await oAuth2ClientManager.createClient();

      expect(client, isA<http.Client>());
    });

    test('throws error', () async {
      final responseHeaders = {'content-type': 'application/json'};
      final responseBody = '{"error": "invalid_request"}';

      http.Response response =
          http.Response(responseBody, 400, headers: responseHeaders);

      when(() => mockHttpClient.post(any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'))).thenAnswer((_) async => response);

      expect(() async => oAuth2ClientManager.createClient(), throwsException);
    });
  });
}
