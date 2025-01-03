import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/input_text.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/notification_controller.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/models/community.dart';
import 'package:volunteer_community_connection_app/models/post.dart';

import '../../components/button_blue.dart';
import '../../components/input_image.dart';
import '../../controllers/user_controller.dart';
import '../bottom_nav/bottom_nav.dart';

class CreatePostScreen extends StatefulWidget {
  final Community community;
  const CreatePostScreen({super.key, required this.community});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? selectedImage;
  String title = '';
  String content = '';
  bool _isLoading = false;

  final Usercontroller _usercontroller = Get.put(Usercontroller());
  final PostController _postController = Get.put(PostController());
  final NotificationController _notificationController =
      Get.put(NotificationController());

  void _createPost() async {
    if (_validatePost()) {
      _showMessage('Vui lòng nhập đầy đủ thống tin', isSuccess: false);
      return;
    }

    final Map<String, String> postData = {
      "Title": title,
      "Content": content,
      "createDate": DateTime.now().toIso8601String(),
      "UserId": _usercontroller.getCurrentUser()!.userId.toString(),
      "CommunityId": widget.community.communityId.toString(),
    };

    try {
      setState(() {
        _isLoading = true;
      });
      var result = await _postController.createPost(postData, selectedImage);

      setState(() {
        _isLoading = false;
      });
      if (result != null) {
        _showMessage('Tạo bài đăng thành công', isSuccess: true);
        _postController.loadedPosts.value =
            await _postController.getPostsByCommunity(
                widget.community.communityId,
                _usercontroller.getCurrentUser()!.userId);
        await createNotification(result);
        _usercontroller.setCurrentUser(await _usercontroller
            .getUser(_usercontroller.getCurrentUser()!.userId));
        Get.to(() => const BottomNavigation());
      } else {
        setState(() {
          _isLoading = false;
        });
        _showMessage('Tạo bài đăng thất bại', isSuccess: false);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showMessage('Tạo bài đăng thất bại', isSuccess: false);
    }
  }

  Future<void> createNotification(Post post) async {
    if (_usercontroller.getCurrentUser()!.userId == widget.community.adminId) {
      return;
    }

    final Map<String, dynamic> notificationData = {
      'content': 'Đã đăng bài tại',
      'title': widget.community.communityName,
      'userId': widget.community.adminId.toString(),
      'senderId': _usercontroller.getCurrentUser()!.userId.toString(),
      'createdAt': DateTime.now().toIso8601String(),
      'isRead': false,
      'type': 'POST',
      'communityId': widget.community.communityId.toString(),
      'postId': post.postId.toString(),
    };

    await _notificationController.createNotification(notificationData);
  }

  bool _validatePost() {
    if (title == '' || content == '') {
      return false;
    }
    return false;
  }

// Hiển thị thông báo
  void _showMessage(String message, {bool isSuccess = false}) {
    Get.snackbar(
      'Tạo dự án',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'Tạo bài đăng',
          style: kLableSize18Black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: _usercontroller
                                .currentUser.value!.avatarUrl !=
                            null
                        ? NetworkImage(
                            _usercontroller.currentUser.value!.avatarUrl!)
                        : const AssetImage('assets/images/default_avatar.jpg')
                            as ImageProvider<Object>,
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(_usercontroller.currentUser.value!.name,
                      style: kLableSize15Black),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  InputText(
                    label: 'Chủ đề',
                    name: '',
                    hinttext: 'Vui lòng nhập chủ đề',
                    isRequired: true,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  InputText(
                    label: 'Cảm nghĩ của bạn',
                    name: '',
                    hinttext: 'Vui lòng nhập cảm nghĩ',
                    isRequired: true,
                    onChanged: (value) {
                      content = value;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  InputImage(
                    label: 'Ảnh minh họa',
                    required: false,
                    onImagePicked: (File? image) {
                      selectedImage = image;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonBlue(
                    isLoading: _isLoading,
                    des: 'Tạo bài đăng',
                    onPress: () => {_createPost()}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
