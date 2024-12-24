import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/input_number.dart';
import 'package:volunteer_community_connection_app/components/input_text.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/models/community.dart';

import '../../components/button_blue.dart';
import '../../components/input_image.dart';
import '../../controllers/user_controller.dart';

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

  final Usercontroller _usercontroller = Get.put(Usercontroller());
  final PostController _postController = Get.put(PostController());

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
      var result = await _postController.createPost(postData, selectedImage);
      if (result) {
        _showMessage('Tạo bài đăng thanh cong', isSuccess: true);
        _postController.getPostsByCommunity(widget.community.communityId);
        Navigator.pop(context);
      } else {
        _showMessage('Tạo bài đăng that bai', isSuccess: false);
      }
    } catch (e) {
      _showMessage('Tạo bài đăng that bai', isSuccess: false);
    }
  }

  bool _validatePost() {
    if (title == '' || content == '') {
      return false;
    }
    return false;
  }

  void _showMessage(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/image_sample.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('Nguyễn Trung Tính', style: kLableSize15Black),
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
                  des: 'Tạo bài đăng', onPress: () => {_createPost()}),
            )
          ],
        ),
      ),
    );
  }
}
