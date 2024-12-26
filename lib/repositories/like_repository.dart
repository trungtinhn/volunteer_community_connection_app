import 'package:volunteer_community_connection_app/services/api_service.dart';

class LikeRepository {
  final ApiService _apiService = ApiService();

  Future<bool> likePost(userId, postId) async {
    var result =
        await _apiService.postBool('/api/Like/like-post/$userId/$postId', null);

    return result;
  }
}
