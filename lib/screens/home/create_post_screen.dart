import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volunteer_community_connection_app/components/input_number.dart';
import 'package:volunteer_community_connection_app/components/input_text.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
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
            InputText(
              label: 'Cảm nghĩ của bạn',
              name: '',
              hinttext: 'Vui lòng nhập cảm nghĩ',
              isRequired: true,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
