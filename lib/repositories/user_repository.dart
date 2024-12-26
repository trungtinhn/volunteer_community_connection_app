import 'dart:io';

import 'package:volunteer_community_connection_app/models/user.dart';
import 'package:volunteer_community_connection_app/services/api_service.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<User?> getUserByEmail(String email) async {
    final data = await _apiService.get('/api/User/get-by-email?email=$email');

    return User.fromJson(data);
  }

  Future<User?> getUser(int userId) async {
    final data = await _apiService.get('/api/User/$userId');

    return User.fromJson(data);
  }

  Future<User?> changeAvatar(int userId, File avatar) async {
    final data = await _apiService.changeAvatar(
        '/api/User/change-avatar/$userId', avatar);

    return User.fromJson(data);
  }
}
