import 'package:volunteer_community_connection_app/models/post.dart';

import '../services/api_service.dart';

class PostRepository {
  final ApiService _apiService = ApiService();

  Future<List<Post>> getPostsByCommunity(int communityId) async {
    final data = await _apiService
        .getAll('/api/Post/get-posts-by-community/$communityId');
    return List<Post>.from(data.map((e) => Post.fromJson(e)));
  }
}
