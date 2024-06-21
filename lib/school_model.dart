import 'package:flutter/material.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/school_repository.dart';

class SchoolModel extends ChangeNotifier {
  final SchoolRepository _schoolRepository;

  String _initialRoute = Paths.splash;

  SchoolModel({required SchoolRepository schoolRepository})
      : _schoolRepository = schoolRepository;

  String get test => "Test";

  Future<String> get initialRoute async {
    // func() async {
    //   bool isAuth = await _schoolRepository.isAuthenticated();
    //   if (!isAuth && _initialRoute != Paths.login) {
    //     _initialRoute = Paths.login;
    //     notifyListeners();
    //   } else if (_initialRoute != Paths.home) {
    //     _initialRoute = Paths.home;
    //     notifyListeners();
    //   }
    // }

    // func();

    bool isAuth = await _schoolRepository.isAuthenticated();

    if (isAuth) {
      _initialRoute = Paths.home;
    } else {
      _initialRoute = Paths.login;
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
