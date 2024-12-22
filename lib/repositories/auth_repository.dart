import 'package:volunteer_community_connection_app/services/api_service.dart';

import '../models/user.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<String?> login(String email, String password) async {
    final data = await _apiService
        .post('/api/Auth/login', {'email': email, 'password': password});

    final token = data['token'];
    return token;
  }

  Future<bool> register(User user, String password) async {
    try {
      var mapUser = await _apiService.post('/api/Auth/register', {
        'name': user.name,
        'email': user.email,
        'password': password,
        'phoneNumber': user.phoneNumber,
        'dayOfBirth': user.dayOfBirth.toIso8601String()
      });

      User newUser = User.fromJson(mapUser);

      if (newUser.email == user.email) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
