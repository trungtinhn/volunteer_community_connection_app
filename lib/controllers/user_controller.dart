import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/models/user.dart';

class Usercontroller extends GetxController {
  static final Usercontroller _instance = Usercontroller._internal();
  factory Usercontroller() => _instance;
  Usercontroller._internal();

  var currentUser = Rx<User?>(null);

  void setCurrentUser(User? user) {
    currentUser.value = user;
  }

  User? getCurrentUser() {
    return currentUser.value;
  }
}
