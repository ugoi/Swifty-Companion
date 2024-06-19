import 'package:flutter/material.dart';
import 'package:swifty_companion/school_repository.dart';

class SchoolModel extends ChangeNotifier {
  final SchoolRepository _schoolRepository;

  SchoolModel({required SchoolRepository schoolRepository})
      : _schoolRepository = schoolRepository;

  Future<void> login() async {
    await _schoolRepository.loginWith42();
  }
}
