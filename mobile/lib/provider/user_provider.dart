import 'package:flutter/material.dart';
import 'package:mobile/model/user_model.dart';
import 'package:mobile/service/user_service.dart';

class UserProvider with ChangeNotifier {
  UserService userService = UserService();
  User? currentUser;

  Future<bool> login(String email, String password) async {
    try {
      currentUser = await userService.login(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      currentUser = await userService.signUp(name, email, password);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    await userService.logout();
    currentUser = null;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    currentUser = await userService.checkLoggedIn();
    notifyListeners();
  }
}
