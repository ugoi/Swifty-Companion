import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:file/local.dart';
import 'package:swifty_companion/environment.dart';
import 'package:swifty_companion/o_auth2_service.dart';
import 'package:swifty_companion/school_repository.dart';
import 'package:swifty_companion/school_service_facade.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolRepositoryFactory {
  static Future<SchoolRepository> createRepository() async {
    return SchoolRepository(
        schoolService: SchoolServiceFacade(
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
        appLinks.uriLinkStream.listen((uri) {
          print('onAppLink: $uri');
          completer.complete(uri);
        });

        return completer.future;
      },
    )));
  }
}
