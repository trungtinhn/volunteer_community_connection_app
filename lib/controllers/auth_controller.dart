import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volunteer_community_connection_app/models/user.dart';
import 'package:volunteer_community_connection_app/repositories/auth_repository.dart';

class Authcontroller extends GetxController {
  static final Authcontroller _instance = Authcontroller._internal();
  factory Authcontroller() => _instance;
  Authcontroller._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final RxBool _isLoggedIn = false.obs;
  final AuthRepository _authRepository = AuthRepository();
  Future<bool> login(String email, String password) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? token = await _authRepository.login(email, password);
      if (token != null) {
        await prefs.setString('token', token);
        _isLoggedIn.value = true;

        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<bool> register(User user, String password) async {
    try {
      final bool result = await _authRepository.register(user, password);

      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('token');
    _isLoggedIn.value = false;
    return true;
  }
}
