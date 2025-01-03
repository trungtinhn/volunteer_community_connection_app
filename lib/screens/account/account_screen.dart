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
import 'package:volunteer_community_connection_app/models/user.dart';
import 'package:volunteer_community_connection_app/screens/home/detail_post_screen.dart';

import '../../models/message.dart';
import '../../models/post.dart';
import '../chat/detail_chat_screen.dart';

class AccountScreen extends StatefulWidget {
  final User user;
  const AccountScreen({super.key, required this.user});

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

  User? _selectedUser;
  List<Post> _listPosts = [];

  Future<void> _fetchPosts() async {
    _listPosts.clear();
    _listPosts = await _postController.getPostsByUser(
      _selectedUser!.userId,
      _usercontroller.getCurrentUser()!.userId,
    );
    setState(() {});
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
          _selectedUser!.userId, _selectedImage!);
      if (user != null) {
        _selectedUser = user;

        setState(() {
          _selectedImage = null;
        });

        if (_usercontroller.getCurrentUser()!.userId == _selectedUser!.userId) {
          _usercontroller.setCurrentUser(user);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedUser = widget.user;
    _fetchPosts();
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedUser!.avatarUrl != null
                        ? NetworkImage(
                            _selectedUser!.avatarUrl!,
                          )
                        : const AssetImage('assets/images/default_avatar.jpg')
                            as ImageProvider,
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
              Text(
                _selectedUser!.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _selectedUser!.email,
                style: const TextStyle(
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
                  _buildStatistic(
                      _selectedUser!.countPosts.toString(), 'Bài đăng'),
                  _buildStatistic(_selectedUser!.countDonate.toString(),
                      'Số lần quyên góp'),
                ],
              ),
              const SizedBox(height: 20),

              // Nút hành động
              if (_usercontroller.getCurrentUser()!.userId !=
                  _selectedUser!.userId)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(Icons.email, Colors.blue, () {
                      var message = Message(
                        senderId: _usercontroller.getCurrentUser()!.userId,
                        receiverId: _selectedUser!.userId,
                        content: '',
                        sentAt: DateTime.now(),
                        isRead: false,
                        id: 0,
                        unreadCount: 0,
                        userName: _selectedUser!.name,
                        avatarUrl: _selectedUser!.avatarUrl ?? '',
                        imageUrl: '',
                      );

                      Get.to(() => DetailChatScreen(message: message));
                    }),
                  ],
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _listPosts.length,
                itemBuilder: (context, index) {
                  var post = _listPosts[index];
                  return PostCard(
                    onTapViewAccount: () async {
                      var user = await _usercontroller.getUser(post.userId);

                      Get.to(() => AccountScreen(user: user!));
                    },
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
  Widget _buildActionButton(IconData icon, Color color, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
