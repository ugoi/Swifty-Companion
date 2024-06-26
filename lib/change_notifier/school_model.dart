import 'package:flutter/material.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/school_repository.dart';

class SchoolModel extends ChangeNotifier {
  final SchoolRepository _schoolRepository;

  PathEnum _initialRoute = PathEnum.splash;

  SchoolModel({required SchoolRepository schoolRepository})
      : _schoolRepository = schoolRepository;

  String get test => "Test";

  Future<PathEnum> get initialRoute async {
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
}
