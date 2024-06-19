import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swifty_companion/i_client_manager.dart';
import 'package:swifty_companion/school_service.dart';
import 'package:swifty_companion/logging_setup.dart';
import 'package:http/http.dart' as http;

class MockClientManager extends Mock implements IClientManager {}

class MockBaseClient extends Mock implements http.BaseClient {}

void main() {
  late MockClientManager mockOAuth2ClientManager;
  late SchoolService schoolService;

  setUp(() {
    mockOAuth2ClientManager = MockClientManager();
    schoolService = SchoolService(clientManager: mockOAuth2ClientManager);
  });

  setUpAll(() {
    setupLogging();
  });

  group('SchoolService', () {
    group('loginWith42', () {
      test('is successful', () async {
        final client = MockBaseClient();
        bool isCompleted = false;
        when(() => mockOAuth2ClientManager.createClient())
            .thenAnswer((_) async => Future.delayed(Duration(seconds: 2), () {
                  isCompleted = true;
                  return client;
                }));
        await schoolService.loginWith42();
        verify(() => mockOAuth2ClientManager.createClient());
        expect(isCompleted, true);
      });

      test('throws error', () async {
        when(() => mockOAuth2ClientManager.createClient())
            .thenThrow(Exception());

        expect(schoolService.loginWith42(), throwsException);
      });
    });
  });
}
