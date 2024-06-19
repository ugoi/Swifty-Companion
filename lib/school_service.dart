import 'package:swifty_companion/dtos/search_user_dto.dart';
import 'package:swifty_companion/dtos/user_dto.dart';
import 'package:swifty_companion/i_client_manager.dart';

class SchoolService {
  final IClientManager _clientManager;

  SchoolService({required IClientManager clientManager})
      : _clientManager = clientManager;

  Future<void> loginWith42() async {
    await _clientManager.createClient();
    return;
  }

  Future<UserDto> getUser() async {
    return Future.value(UserDto());
  }

  Future<List<SearchUserDto>> searchUsers(String query) async {
    return Future.value(List<SearchUserDto>.empty());
  }
}
