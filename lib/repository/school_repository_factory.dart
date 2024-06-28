import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:file/local.dart';
import 'package:logging/logging.dart';
import 'package:swifty_companion/environment.dart';
import 'package:swifty_companion/service/o_auth2_service.dart';
import 'package:swifty_companion/repository/school_repository.dart';
import 'package:swifty_companion/service/school_service_facade.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolRepositoryFactory {
  static final Logger _logger = Logger("SchoolRepositoryFactory");
  static Future<SchoolRepository> createRepository() async {
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

    return SchoolRepository(schoolService: schoolServiceFacade);
  }
}
