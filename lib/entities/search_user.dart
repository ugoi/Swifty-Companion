import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/entities/user_image.dart';

class SearchUser {
  final String login;
  final UserImage profilePicture;

  static const String _notFound = "N/A";

  SearchUser({String? login, UserImage? profilePicture})
      : login = login ?? _notFound,
        profilePicture = profilePicture ?? const UserImage();

  factory SearchUser.fromSearchUserDtos(SearchUserDto searchUserDtos) {
    return SearchUser(
        login: searchUserDtos.login,
        profilePicture: UserImage(
            url: searchUserDtos.image?.link,
            versions: ImageVersions(
                large: searchUserDtos.image?.versions?.large,
                medium: searchUserDtos.image?.versions?.medium,
                micro: searchUserDtos.image?.versions?.micro,
                small: searchUserDtos.image?.versions?.small)));
  }
}
