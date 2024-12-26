import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/post_card.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/like_controller.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/models/community.dart';
import 'package:volunteer_community_connection_app/screens/home/create_post_screen.dart';
import 'package:volunteer_community_connection_app/screens/home/detail_post_screen.dart';

import '../screens/account/account_screen.dart';

class PostTab extends StatefulWidget {
  final Community community;
  const PostTab({super.key, required this.community});

  @override
  State<PostTab> createState() => PostTabState();
}

class PostTabState extends State<PostTab> {
  // Dữ liệu mẫu cho các bài viết
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'Bruno Pham',
      'timeAgo': '2 minutes ago',
      'description':
          'Chúng tôi đại diện BTC cộng đồng gây quỹ ánh sáng xin được phép kêu gọi quỹ mạnh thường quân hành động thiện nguyện tại tổ chức ...',
      'imageUrl': 'assets/images/covid_relief.jpg',
      'likes': 125,
      'comments': 50,
      'shares': 10,
    },
    {
      'username': 'Alice Nguyen',
      'timeAgo': '5 hours ago',
      'description':
          'Hãy tham gia chúng tôi trong chiến dịch mới này và giúp đỡ cộng đồng!',
      'imageUrl': 'assets/images/flood_relief.jpg',
      'likes': 200,
      'comments': 30,
      'shares': 12,
    },
  ];

  final PostController _postController = Get.put(PostController());
  final LikeController _likeController = Get.put(LikeController());
  final Usercontroller _usercontroller = Get.put(Usercontroller());

  Future<void> likePost(int postId) async {
    var result = await _likeController.likePost(
        _usercontroller.getCurrentUser()!.userId, postId);
    if (result) {
      var post = await _postController.getPost(
          postId, _usercontroller.getCurrentUser()!.userId);
      await _postController.updateLoadedPosts(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chia sẻ bài đăng', style: kLableSize18Black),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: _usercontroller.getCurrentUser()!.avatarUrl !=
                        null
                    ? NetworkImage(_usercontroller.getCurrentUser()!.avatarUrl!)
                    : const AssetImage('assets/images/default_avatar.jpg')
                        as ImageProvider<Object>,
                radius: 25,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePostScreen(
                        community: widget.community,
                      ),
                    ),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.greyIron, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Chia sẻ của nghĩ của bạn về dự án',
                        style: kLableSize15Grey,
                      ),
                    )),
              )
            ],
          ),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _postController.loadedPosts.length,
              itemBuilder: (context, index) {
                var post = _postController.loadedPosts[index];
                return PostCard(
                  onTapViewAccount: () async {
                    var user = await _usercontroller.getUser(post.userId);

                    Get.to(() => AccountScreen(user: user!));
                  },
                  onTapLike: () {
                    likePost(post.postId);
                  },
                  post: post,
                  showCommunity: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPostScreen(
                          post: post,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
