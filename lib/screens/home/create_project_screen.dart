import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/components/input_number.dart';
import 'package:volunteer_community_connection_app/components/input_text.dart';
import 'package:volunteer_community_connection_app/components/input_text_multiline.dart';
import 'package:volunteer_community_connection_app/components/input_time.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Tạo dự án',
          style: kLableSize20w700Black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                InputText(
                  label: 'Tên dự án',
                  name: '',
                  hinttext: 'Vì một hành tinh xanh',
                  isRequired: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InputTextMultiline(
                    label: 'Mô tả',
                    name: '',
                    hinttext: 'Nhập mô tả',
                    onChanged: (value) {}),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InputTimePicker(
                    label: 'Ngày bắt đầu',
                    name: '',
                    hinttext: '',
                    onChanged: (value) {}),
                const SizedBox(
                  width: 8,
                ),
                InputTimePicker(
                    label: 'Ngày kết thúc',
                    name: '',
                    hinttext: '',
                    onChanged: (value) {})
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InputNumberField(
                    label: 'Số tiên mục tiêu',
                    name: '',
                    hinttext: '100000',
                    onChanged: (value) {}),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonBlue(des: 'Tạo dự án', onPress: () {}),
            )
          ],
        ),
      ),
    );
  }
}
