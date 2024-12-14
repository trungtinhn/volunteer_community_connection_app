import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volunteer_community_connection_app/repositories/auth_repository.dart';

class Authcontroller extends GetxController {
  static final Authcontroller _instance = Authcontroller._internal();
  factory Authcontroller() => _instance;
  Authcontroller._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final RxBool _isLoggedIn = false.obs;
  final AuthRepository _authRepository = AuthRepository();
  Future<bool> login(String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = await _authRepository.login(email, password);
    if (token != null) {
      await prefs.setString('token', token);
      _isLoggedIn.value = true;

      return true;
    }
    return false;
  }
}
