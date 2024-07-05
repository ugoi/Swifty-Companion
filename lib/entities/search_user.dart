import 'package:swifty_companion/entities/user_image.dart';

class SearchUser {
  final String id;
  final String login;
  final UserImage profilePicture;

  static const String _notFound = "N/A";

  SearchUser({required this.id, String? login, UserImage? profilePicture})
      : login = login ?? _notFound,
        profilePicture = profilePicture ?? const UserImage();
}
