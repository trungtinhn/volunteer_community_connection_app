import 'dart:io';

import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/repositories/post_repository.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/post.dart';

class PostController extends GetxController {
  static final PostController _instance = PostController._internal();
  factory PostController() => _instance;
  PostController._internal();

  final PostRepository _postRepository = PostRepository();

  RxList<Post> loadedPosts = <Post>[].obs;

  Future<List<Post>> getPostsByCommunity(int communityId) async {
    var posts = await _postRepository.getPostsByCommunity(communityId);

    for (var post in posts) {
      post.timeAgo = timeago.format(post.createDate, locale: 'vi');
    }

    return posts;
  }

  Future<void> setEmptyPosts() async {
    loadedPosts.value = <Post>[];
  }

  Future<bool> createPost(Map<String, String> postData, File? image) {
    return _postRepository.createPost(postData, image);
  }
}
