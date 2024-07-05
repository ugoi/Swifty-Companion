import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

import 'package:path_provider/path_provider.dart';

class Environment {
  static final Logger _logger = Logger("Enironment");

  static Future<void> init() async {
    try {
      await dotenv.load(fileName: fileName);
      _logger.info('Environment variables loaded successfully');
    } catch (e) {
      _logger.severe('Error loading environment variables: $e');
      rethrow;
    }
  }

  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.development';
    }
  }

  static String get authorizationEndpoint {
    return dotenv.env['AUTHORIZATION_ENDPOINT']!;
  }

  static String get redirectUrl {
    return dotenv.env['REDIRECT_URL']!;
  }

  static String get tokenEndpoint {
    return dotenv.env['TOKEN_ENDPOINT']!;
  }

  static String get identifier {
    return dotenv.env['IDENTIFIER']!;
  }

  static String get secret {
    return dotenv.env['SECRET']!;
  }

  static Future<String> get credentialsFilePath async {
    Directory? directory;

    directory = await getApplicationDocumentsDirectory();

    final path = directory?.path ?? '';

    final credentialsFileName = dotenv.env['CREDENTIALS_FILE_NAME'] ?? '';

    final credentialsFilePath = '$path/$credentialsFileName';
    return credentialsFilePath;
  }

  static Future<String> get searchUsersFilePath async {
    Directory? directory;

    directory = await getApplicationDocumentsDirectory();

    final path = directory?.path ?? '';

    final credentialsFileName = dotenv.env['SEARCH_USERS_FILE_PATH']!;

    final credentialsFilePath = '$path/$credentialsFileName';

    return credentialsFilePath;
  }
}
