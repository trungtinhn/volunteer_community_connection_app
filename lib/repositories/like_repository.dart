import 'package:volunteer_community_connection_app/services/api_service.dart';

class LikeRepository {
  final ApiService _apiService = ApiService();

  Future<void> likePost(userId, postId) async {
    await _apiService.post('/api/Like/like-post/$userId/$postId', null);
  }
}
