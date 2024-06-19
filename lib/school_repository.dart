import 'package:logging/logging.dart';
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_data.dart';
import 'package:swifty_companion/school_service_facade.dart';

class SchoolRepository {
  final SchoolServiceFacade _schoolService;
  final Logger _logger = Logger("SchoolRepository");

  SchoolRepository({required SchoolServiceFacade schoolService})
      : _schoolService = schoolService;

  Future<void> loginWith42() async {
    try {
      return _schoolService.loginWith42();
    } catch (e, stackTrace) {
      _logger.severe('loginWith42() failed to fetch user data', e, stackTrace);
      throw Exception('loginWith42() failed to fetch user data');
    }
  }

  // Took me 1 hour to write this and its subroutines
  Future<UserData> getUserData(String id) async {
    try {
      final userDto = await _schoolService.getUser(id);
      return UserData.fromUserDto(userDto);
    } catch (e, stackTrace) {
      // log error
      _logger.severe('getUserData() failed to fetch user data', e, stackTrace);
      throw Exception('getUserData() failed to fetch user data');
    }
  }

  // Took me 1 hour to write this function
  Future<List<SearchUser>> searchUsers(String query) async {
    try {
      final searchUserDtos = await _schoolService.searchUsers(query);

      return searchUserDtos
          .map((e) => SearchUser.fromSearchUserDtos(e))
          .toList();
    } catch (e, stackTrace) {
      _logger.severe(
          'searchUsers(String query) failed to fetch user data', e, stackTrace);
      throw Exception('getUserData() failed to fetch user data');
    }
  }
}
