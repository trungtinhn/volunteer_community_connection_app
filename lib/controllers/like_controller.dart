import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/repositories/like_repository.dart';

class LikeController extends GetxController {
  static final LikeController _instance = LikeController._internal();
  factory LikeController() => _instance;
  LikeController._internal();

  final LikeRepository likeRepository = LikeRepository();

  Future<bool> likePost(userId, postId) async {
    return await likeRepository.likePost(userId, postId);
  }
}
