import 'dart:io';

import 'package:volunteer_community_connection_app/models/post.dart';

import '../services/api_service.dart';

class PostRepository {
  final ApiService _apiService = ApiService();

  Future<List<Post>> getPostsByCommunity(int communityId) async {
    final data = await _apiService
        .getAll('/api/Post/get-posts-by-community/$communityId');
    return List<Post>.from(data.map((e) => Post.fromJson(e)));
  }

  Future<List<Post>> getPostByUser(int userId) async {
    final data =
        await _apiService.getAll('/api/Post/get-posts-by-user/$userId');
    return List<Post>.from(data.map((e) => Post.fromJson(e)));
  }

  Future<bool> createPost(Map<String, String> postData, File? image) async {
    var result =
        await _apiService.createFormDataWithImage('/api/Post', postData, image);

    if (result != null) {
      return true;
    } else {
      return false;
    }
  }
}
