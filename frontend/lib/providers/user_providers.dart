import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _username;
  String? _role;
  String? _authToken;
  int? _userId;

  String? get username => _username;
  String? get role => _role;
  String? get authToken => _authToken;
  int? get userId => _userId;

  UserProvider() {
    // _initializeDummyData();
  }

  void setUser(
      {required String username,
      required String role,
      required String authToken,
      required int userId}) {
    _username = username;
    _role = role;
    _authToken = authToken;
    _userId = userId;
    notifyListeners();
  }

  void clearUser() {
    _username = null;
    _role = null;
    _authToken = null;
    _userId = null;
    notifyListeners();
  }

  void _initializeDummyData() {
    _username = 'John Doe';
    _authToken = 'dummy_auth_token_12345';
    _role = 'researcher';
    _userId = 1;
  }
}
