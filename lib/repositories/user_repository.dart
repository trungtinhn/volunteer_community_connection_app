import 'package:volunteer_community_connection_app/models/user.dart';
import 'package:volunteer_community_connection_app/services/api_service.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<User?> getUserByEmail(String email) async {
    final data = await _apiService.get('/api/User/get-by-email?email=$email');

    return User.fromJson(data);
  }
}
