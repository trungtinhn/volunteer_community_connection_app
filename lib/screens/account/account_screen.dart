import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volunteer_community_connection_app/components/post_card.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/controllers/like_controller.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/screens/home/detail_post_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Usercontroller _usercontroller = Get.put(Usercontroller());
  final PostController _postController = Get.put(PostController());
  final LikeController _likeController = Get.put(LikeController());

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

  Future<void> _fetchMyPosts() async {
    _postController.myPosts.clear();
    _postController.myPosts.value = await _postController.getPostsByUser(
      _usercontroller.getCurrentUser()!.userId,
      _usercontroller.getCurrentUser()!.userId,
    );
  }

  Future<void> likePost(int postId) async {
    await _likeController.likePost(
        _usercontroller.getCurrentUser()!.userId, postId);
    var post = await _postController.getPost(
        postId, _usercontroller.getCurrentUser()!.userId);
    await _postController.updateLoadedPosts(post);
  }

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image picker error: $e");
    }
  }

  void _changeAvatar() async {
    await _pickImage(ImageSource.gallery);
    if (_selectedImage != null) {
      var user = await _usercontroller.changeAvatar(
          _usercontroller.getCurrentUser()!.userId, _selectedImage!);
      if (user != null) {
        _usercontroller.setCurrentUser(user);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Ảnh đại diện
              Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 50,
                      backgroundImage: _usercontroller
                                  .getCurrentUser()!
                                  .avatarUrl !=
                              null
                          ? NetworkImage(
                              _usercontroller.getCurrentUser()!.avatarUrl!,
                            )
                          : const AssetImage('assets/images/default_avatar.jpg')
                              as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        _changeAvatar();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColors.darkBlue, shape: BoxShape.circle),
                        child: SvgPicture.asset('assets/icons/camera.svg'),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              // Tên và mô tả
              const Text(
                'Bruno Pham',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Sống một đời an nhiên và hạnh phúc',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Hàng thống kê
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatistic('140', 'Bài đăng'),
                  _buildStatistic('14.5K', 'Bạn bè'),
                  _buildStatistic('250K', 'Số lần quyên góp'),
                ],
              ),
              const SizedBox(height: 20),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(Icons.person_add, AppColors.darkBlue),
                  const SizedBox(width: 20),
                  _buildActionButton(Icons.email, Colors.blue),
                ],
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _postController.myPosts.length,
                  itemBuilder: (context, index) {
                    var post = _postController.myPosts[index];
                    return PostCard(
                      onTapLike: () {
                        likePost(post.postId);
                      },
                      post: post,
                      showCommunity: true,
                      onTap: () {
                        Get.to(() => DetailPostScreen(
                              post: post,
                            ));
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng thống kê
  Widget _buildStatistic(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Hàm xây dựng nút hành động
  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
