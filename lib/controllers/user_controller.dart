import 'dart:io';

import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/models/user.dart';
import 'package:volunteer_community_connection_app/repositories/user_repository.dart';

class Usercontroller extends GetxController {
  static final Usercontroller _instance = Usercontroller._internal();
  factory Usercontroller() => _instance;
  Usercontroller._internal();

  final UserRepository _userRepository = UserRepository();

  var currentUser = Rx<User?>(null);

  void setCurrentUser(User? user) {
    currentUser.value = user;
  }

  User? getCurrentUser() {
    return currentUser.value;
  }

  Future<User?> getUserByEmail(String email) async {
    var user = await _userRepository.getUserByEmail(email);

    return user;
  }

  Future<User?> changeAvatar(int userId, File avatar) async {
    var user = await _userRepository.changeAvatar(userId, avatar);
    return user;
  }

  Future<User?> getUser(int userId) async {
    var user = await _userRepository.getUser(userId);
    return user;
  }

  void removeCurrentUser() {
    currentUser.value = null;
  }
}
