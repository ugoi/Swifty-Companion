
import 'package:logging/logging.dart';
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_data.dart';
import 'package:swifty_companion/entities/user_image.dart';
import 'package:swifty_companion/service/school_service_facade.dart';

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
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    return _schoolService.isAuthenticated();
  }

  Future<void> logout() async {
    return _schoolService.logout();
  }

  // Took me 1 hour to write this and its subroutines
  Future<UserData> getUserData(String id) async {
    try {
      final userDto = await _schoolService.getUser(id);
      return UserData.fromUserDto(userDto);
    } catch (e, stackTrace) {
      // log error
      _logger.severe('getUserData() failed to fetch user data', e, stackTrace);
      rethrow;
    }
  }

  // Took me 1 hour to write this function
  Future<List<SearchUser>> searchUsers(String query) async {
    try {
      final searchUserDtos = (await _schoolService.searchUsers(query)).toList();

      return searchUserDtos
          .map((e) => SearchUser(
              id: e.id.toString(),
              login: e.login,
              profilePicture: UserImage(
                  url: e.image?.link,
                  versions: ImageVersions(
                      large: e.image?.versions?.large,
                      medium: e.image?.versions?.medium,
                      micro: e.image?.versions?.micro,
                      small: e.image?.versions?.small))))
          .toList();
    } catch (e, stackTrace) {
      _logger.severe(
          'searchUsers(String query) failed to fetch user data', e, stackTrace);
      rethrow;
    }
  }
}
