import 'package:file/file.dart';
import 'package:swifty_companion/i_auth_service.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

class OAuth2Service implements IAuthService {
  final Future<void> Function(Uri uri) _redirect;
  final Future<Uri> Function(Uri uri) _listen;
  final FileSystem _fileSystem;
  final Uri _authorizationEndpoint;
  final Uri _tokenEndpoint;
  final String _identifier;
  final String _secret;
  final Uri _redirectUrl;
  final String _credentialsFilePath;
  final http.Client? _httpClient;

  OAuth2Service(
      {required Future<void> Function(Uri uri) redirect,
      required Future<Uri> Function(Uri uri) listen,
      required FileSystem fileSystem,
      required String authorizationEndpoint,
      required String tokenEndpoint,
      required String identifier,
      required String secret,
      required String redirectUrl,
      required String credentialsFilePath,
      http.Client? httpClient})
      : _redirect = redirect,
        _listen = listen,
        _fileSystem = fileSystem,
        _authorizationEndpoint = Uri.parse(authorizationEndpoint),
        _tokenEndpoint = Uri.parse(tokenEndpoint),
        _identifier = identifier,
        _secret = secret,
        _redirectUrl = Uri.parse(redirectUrl),
        _credentialsFilePath = credentialsFilePath,
        _httpClient = httpClient;

  @override
  Future<oauth2.Client> createClient() async {
    try {
      /// A file in which the users credentials are stored persistently. If the server
      /// issues a refresh token allowing the client to refresh outdated credentials,
      /// these may be valid indefinitely, meaning the user never has to
      /// re-authenticate.
      final credentialsFile = _fileSystem.file(_credentialsFilePath);
      var exists = await credentialsFile.exists();

      // If the OAuth2 credentials have already been saved from a previous run, we
      // ust want to reload them.
      if (exists) {
        var credentials =
            oauth2.Credentials.fromJson(await credentialsFile.readAsString());
        return oauth2.Client(credentials,
            identifier: _identifier, secret: _secret);
      }

      // If we don't have OAuth2 credentials yet, we need to get the resource owner
      // to authorize us. We're assuming here that we're a command-line application.

      var grant = oauth2.AuthorizationCodeGrant(
        _identifier,
        _authorizationEndpoint,
        _tokenEndpoint,
        secret: _secret,
        httpClient: _httpClient,
        onCredentialsRefreshed: (p0) async =>
            await credentialsFile.writeAsString(p0.toJson()),
      );

      // A URL on the authorization server (authorizationEndpoint with some additional
      // query parameters). Scopes and state can optionally be passed into this method.
      var authorizationUrl = grant.getAuthorizationUrl(_redirectUrl);

      // Redirect the resource owner to the authorization URL. Once the resource
      // owner has authorized, they'll be redirected to `redirectUrl` with an
      // authorization code. The `redirect` should cause the browser to redirect to
      // another URL which should also have a listener.
      //
      // `redirect` and `listen` are not shown implemented here. See below for the
      // details.
      await _redirect(authorizationUrl);
      var responseUrl = await _listen(_redirectUrl);

      // Once the user is redirected to `redirectUrl`, pass the query parameters to
      // the AuthorizationCodeGrant. It will validate them and extract the
      // authorization code to create a new Client.
      final oauth2.Client client =
          await grant.handleAuthorizationResponse(responseUrl.queryParameters);

      await credentialsFile.writeAsString(client.credentials.toJson());

      return client;
    } catch (e) {
      throw Exception('Failed to create OAuth2 client: $e');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final credentialsFile = _fileSystem.file(_credentialsFilePath);
    var exists = await credentialsFile.exists();
    // If the OAuth2 credentials have already been saved from a previous run, we
    // ust want to reload them.
    if (exists) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    final credentialsFile = _fileSystem.file(_credentialsFilePath);
    credentialsFile.delete();
  }
}
