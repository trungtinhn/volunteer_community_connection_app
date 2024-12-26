import 'package:volunteer_community_connection_app/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<String?> login(String email, String password) async {
    final data = await _apiService
        .post('/api/Auth/login', {'email': email, 'password': password});
    final token = data['token'];
    return token;
  }
}
