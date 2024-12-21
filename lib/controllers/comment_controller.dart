import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/repositories/comment_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/comment.dart';

class CommentController extends GetxController {
  static final CommentController _instance = CommentController._internal();
  factory CommentController() => _instance;
  CommentController._internal();

  final CommentRepository _commentRepository = CommentRepository();

  RxList<Comment> loadedComment = <Comment>[].obs;

  Future<List<Comment>> getCommentsByPost(int postId) async {
    var comments = await _commentRepository.getCommentsByPost(postId);

    for (var comment in comments) {
      comment.timeAgo = timeago.format(comment.createDate, locale: 'vi');
    }
    return comments;
  }

  Future<void> setEmptyComment() async {
    loadedComment.value = [];
  }
}
