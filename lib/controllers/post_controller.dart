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
  RxList<Post> myPosts = <Post>[].obs;

  Future<void> updateLoadedPosts(Post post) async {
    int index =
        loadedPosts.indexWhere((element) => element.postId == post.postId);
    if (index != -1) {
      loadedPosts[index] = post;
    }
  }

  Future<List<Post>> getPostsByCommunity(int communityId, int userId) async {
    var posts = await _postRepository.getPostsByCommunity(communityId, userId);

    for (var post in posts) {
      post.timeAgo = timeago.format(post.createDate, locale: 'vi');
    }

    return posts;
  }

  Future<List<Post>> getPostsByUser(int userId, int myId) async {
    var posts = await _postRepository.getPostByUser(userId, myId);

    for (var post in posts) {
      post.timeAgo = timeago.format(post.createDate, locale: 'vi');
    }

    return posts;
  }

  Future<Post> getPost(int postId, int userId) async {
    var post = await _postRepository.getPost(postId, userId);

    post.timeAgo = timeago.format(post.createDate, locale: 'vi');

    return post;
  }

  Future<void> setEmptyPosts() async {
    loadedPosts.value = <Post>[];
  }

  Future<bool> createPost(Map<String, String> postData, File? image) {
    return _postRepository.createPost(postData, image);
  }
}
