import 'package:mobile/model/user_model.dart';
import 'package:mobile/repository/user_repository.dart';

class UserService {
  final UserRepository userRepository = UserRepository();

  Future<User> login(String email, String password) =>
      userRepository.authenticate(email, password);

  Future<User> signUp(String name, String email, String password) =>
      userRepository.authenticate(email, password, name: name, isLogin: false);

  Future<void> logout() => userRepository.clearUser();
  Future<User?> checkLoggedIn() async {
    return userRepository.getLoggedInUser();
  }
}
