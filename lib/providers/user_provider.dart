import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods authMethods = AuthMethods();

  User get getUster => _user!;

  Future<void> refreshUser() async {
    final User user = await authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
