import 'package:volunteer_community_connection_app/models/comment.dart';

import '../services/api_service.dart';

class CommentRepository {
  final ApiService _apiService = ApiService();

  Future<List<Comment>> getCommentsByPost(int postId) async {
    final data = await _apiService.getAll('/api/Comment/$postId/comments');
    return List<Comment>.from(data.map((e) => Comment.fromJson(e)));
  }

  Future<void> createComment(Map<String, dynamic> comment) async {
    await _apiService.post('/api/Comment', comment);
  }
}
