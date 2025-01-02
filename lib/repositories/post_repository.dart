import 'dart:io';

import 'package:volunteer_community_connection_app/models/post.dart';

import '../services/api_service.dart';

class PostRepository {
  final ApiService _apiService = ApiService();

  Future<List<Post>> getPostsByCommunity(int communityId, int userId) async {
    final data = await _apiService
        .getAll('/api/Post/get-posts-by-community/$communityId/$userId');
    return List<Post>.from(data.map((e) => Post.fromJson(e)));
  }

  Future<List<Post>> getPostByUser(int userId, int myId) async {
    final data =
        await _apiService.getAll('/api/Post/get-posts-by-user/$userId/$myId');
    return List<Post>.from(data.map((e) => Post.fromJson(e)));
  }

  Future<Post> getPost(int postId, int userId) async {
    final data = await _apiService.get('/api/Post/$postId/$userId');
    return Post.fromJson(data);
  }

  Future<Post> createPost(Map<String, String> postData, File? image) async {
    var result =
        await _apiService.createFormDataWithImage('/api/Post', postData, image);

    return Post.fromJson(result);
  }
}
