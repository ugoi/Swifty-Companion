import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:file/local.dart';
import 'package:logging/logging.dart';
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_data.dart';
import 'package:swifty_companion/environment.dart';
import 'package:swifty_companion/service/i_auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/service/o_auth2_service.dart';
import 'package:swifty_companion/service/school_data_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolServiceFacade {
  final IAuthService _authService;
  SchoolDataService? _schoolDataService;
  static final Logger _logger = Logger("SchoolServiceFacade");

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

  Future<UserData> getUser(String id) async {
    if (_schoolDataService == null) {
      throw Exception("Not logged in");
    }
    final userDto = await _schoolDataService!.getUser(id);

    return UserData.fromUserDto(userDto);
  }

  Future<List<SearchUser>> searchUsers(String query) async {
    if (_schoolDataService == null) {
      throw Exception("Not logged in");
    }
    return _schoolDataService!.searchUsers(query);
  }

  static Future<SchoolServiceFacade> create() async {
    final schoolServiceFacade = SchoolServiceFacade(
        clientManager: OAuth2Service(
      authorizationEndpoint: Environment.authorizationEndpoint,
      redirectUrl: Environment.redirectUrl,
      tokenEndpoint: Environment.tokenEndpoint,
      identifier: Environment.identifier,
      secret: Environment.secret,
      credentialsFilePath: await Environment.credentialsFilePath,
      fileSystem: const LocalFileSystem(),
      redirect: (Uri uri) async {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      listen: (Uri uri) async {
        final completer = Completer<Uri>();
        final appLinks = AppLinks(); // AppLinks is singleton

        // Subscribe to all events (initial link and further)
        final subscription = appLinks.uriLinkStream.listen((uri) {
          _logger.info('onAppLink: $uri');
          completer.complete(uri);
        });

        final resultUri = await completer.future;

        subscription.cancel();

        return resultUri;
      },
    ));

    await schoolServiceFacade.init();

    return schoolServiceFacade;
  }
}
