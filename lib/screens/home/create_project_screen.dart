import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/components/input_image.dart';
import 'package:volunteer_community_connection_app/components/input_number.dart';
import 'package:volunteer_community_connection_app/components/input_select.dart';
import 'package:volunteer_community_connection_app/components/input_text.dart';
import 'package:volunteer_community_connection_app/components/input_text_multiline.dart';
import 'package:volunteer_community_connection_app/components/input_time.dart';
import 'package:volunteer_community_connection_app/components/location_picker.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  CommunityController communityController = Get.put(CommunityController());
  Usercontroller userController = Get.put(Usercontroller());
  File? selectedImage;
  String selectedProjectType = 'Quyên góp tiền';
  String name = '';
  String description = '';
  DateTime startDate = DateTime.now().add(const Duration(days: 3));
  DateTime endDate = DateTime.now().add(const Duration(days: 6));
  DateTime currentTime = DateTime.now().add(const Duration(days: 2));
  String? targetAmount;
  double? latitude;
  double? longitude;

  bool isLoading = false;

  void _createProject() async {
    // Kiểm tra dữ liệu hợp lệ
    if (name.isEmpty || description.isEmpty) {
      _showMessage('Vui lòng điền đầy đủ thông tin bắt buộc.');
      return;
    }
    if (startDate.isBefore(currentTime)) {
      _showMessage('Ngày bắt đầu phải sau ngày hôm nay 3 ngày.');
      return;
    }
    if (startDate.isAfter(endDate)) {
      _showMessage('Ngày bắt đầu phải trước ngày kết thúc.');
      return;
    }
    if (selectedProjectType == 'Quyên góp tiền' &&
        (targetAmount == null || targetAmount!.isEmpty)) {
      _showMessage('Vui lòng nhập số tiền mục tiêu.');
      return;
    }
    if (selectedProjectType == 'Quyên góp đồ vật' &&
        (latitude == null || longitude == null)) {
      _showMessage('Vui lòng chọn vị trí quyên góp.');
      return;
    }
    if (selectedImage == null) {
      _showMessage('Vui lòng tải lên ảnh minh họa.');
      return;
    }
    int isPublished = 0;

    if (userController.currentUser.value!.role == 'admin') isPublished = 1;

    // Chuẩn bị dữ liệu dự án
    final Map<String, String> communityData = {
      "CommunityName": name,
      "Description": description,
      "publishStatus": isPublished.toString(), // Mặc định là false
      "AdminId": userController.currentUser.value!.userId.toString(),
      "CreateDate": DateTime.now().toIso8601String(),
      "StartDate": startDate.toIso8601String(),
      "EndDate": endDate.toIso8601String(),
      "TargetAmount": targetAmount ?? "",
      "Type": selectedProjectType,
      "Latitude": latitude?.toStringAsFixed(8) ?? "",
      "Longitude": longitude?.toStringAsFixed(8) ?? "",
    };

    try {
      // Gọi controller để tạo dự án
      await communityController.createCommunityWithImage(
        communityData,
        selectedImage,
      );

      _showMessage('Tạo dự án thành công', isSuccess: true);
    } catch (e) {
      _showMessage('Tạo dự án khóa thất bại: $e', isSuccess: false);
    }
  }

  // Hiển thị thông báo
  void _showMessage(String message, {bool isSuccess = false}) {
    setState(() {
      isLoading = false;
    });
    Get.snackbar(
      'Tạo dự án',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    );
    if (isSuccess) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

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
                  onChanged: (value) {
                    name = value;
                  },
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
                    onChanged: (value) {
                      description = value;
                    }),
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
                    hinttext: formatDate(startDate),
                    onChanged: (value) {
                      startDate = value;
                    }),
                const SizedBox(
                  width: 8,
                ),
                InputTimePicker(
                    label: 'Ngày kết thúc',
                    name: '',
                    hinttext: formatDate(endDate),
                    onChanged: (value) {
                      endDate = value;
                    })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InputSelectData(
                  list: const [
                    'Quyên góp tiền',
                    'Quyên góp đồ vật'
                  ], // Danh sách loại dự án
                  selectedOption: 'Quyên góp tiền', // Lựa chọn mặc định
                  onChanged: (value) {
                    setState(() {
                      selectedProjectType = value;
                    });
                  },
                  label: 'Loại dự án',
                  hinttext: 'Chọn loại dự án',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (selectedProjectType ==
                'Quyên góp tiền') // Hiện trường "Số tiền mục tiêu"
              Row(
                children: [
                  InputNumberField(
                      label: 'Số tiền mục tiêu',
                      name: '',
                      hinttext: 'Nhập số tiền',
                      onChanged: (value) {
                        targetAmount = value;
                      }),
                ],
              ),
            if (selectedProjectType ==
                'Quyên góp đồ vật') // Hiện trường "Vị trí quyên góp"
              Row(
                children: [
                  LocationPicker(
                    onLocationSelected: (value) {
                      latitude = value.latitude;
                      longitude = value.longitude;
                    },
                    label: 'Vị trí quyên góp',
                  ),
                ],
              ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InputImage(
                  label: 'Ảnh minh họa',
                  required: true,
                  onImagePicked: (File? image) {
                    selectedImage = image;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonBlue(
                  isLoading: isLoading,
                  des: 'Tạo dự án',
                  onPress: () => {
                        setState(() {
                          isLoading = true;
                        }),
                        _createProject()
                      }),
            )
          ],
        ),
      ),
    );
  }
}
