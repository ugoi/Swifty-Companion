import 'package:flutter/material.dart';
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_data.dart';
import 'package:swifty_companion/paths.dart';

import 'package:swifty_companion/service/school_service_facade.dart';

class SchoolModel extends ChangeNotifier {
  SchoolModel({required SchoolServiceFacade schoolServiceFacade})
      : _schoolServiceFacade = schoolServiceFacade;

  final SchoolServiceFacade _schoolServiceFacade;
  PathEnum _initialRoute = PathEnum.splash;
  List<SearchUser> _searchUsers = [];
  Future<UserData>? _userData;

  List<SearchUser> get searchUsers => _searchUsers;

  Future<UserData>? get userData => _userData;

  Future<PathEnum> initialRoute() async {

    bool isAuth = await _schoolServiceFacade.isAuthenticated();

    if (isAuth) {
      _initialRoute = PathEnum.search;
    } else {
      _initialRoute = PathEnum.login;
    }
    return _initialRoute;
  }

  Future<void> login() async {
    await _schoolServiceFacade.loginWith42();
  }

  Future<void> logout() async {
    await _schoolServiceFacade.logout();
  }

  Future<void> onSearchSubmitted(String query) async {
    _searchUsers = await _schoolServiceFacade.searchUsers(query.trim());
    notifyListeners();
  }

  Future<void> onSearchUserClicked(String id) async {
    _userData = _schoolServiceFacade.getUser(id);
    notifyListeners();
  }
}
