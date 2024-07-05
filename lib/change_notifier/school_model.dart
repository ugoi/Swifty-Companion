import 'package:flutter/material.dart';
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_data.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/repository/school_repository.dart';

class SchoolModel extends ChangeNotifier {
  SchoolModel({required SchoolRepository schoolRepository})
      : _schoolRepository = schoolRepository;

  final SchoolRepository _schoolRepository;
  PathEnum _initialRoute = PathEnum.splash;
  List<SearchUser> _searchUsers = [];
  Future<UserData>? _userData;

  List<SearchUser> get searchUsers => _searchUsers;

  Future<UserData>? get userData => _userData;

  Future<PathEnum> initialRoute() async {
    bool isAuth = await _schoolRepository.isAuthenticated();

    if (isAuth) {
      _initialRoute = PathEnum.search;
    } else {
      _initialRoute = PathEnum.login;
    }
    return _initialRoute;
  }

  Future<void> login() async {
    await _schoolRepository.loginWith42();
  }

  Future<void> logout() async {
    await _schoolRepository.logout();
  }

  Future<void> onSearchSubmitted(String query) async {
    _searchUsers = await _schoolRepository.searchUsers(query.trim());
    notifyListeners();
  }

  Future<void> onSearchUserClicked(String id) async {
    _userData = _schoolRepository.getUserData(id);
    notifyListeners();
  }
}
