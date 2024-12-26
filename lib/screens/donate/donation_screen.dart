import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/components/input_number.dart';
import 'package:volunteer_community_connection_app/components/input_text_multiline.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/screens/donate/pay_donation_screen.dart';
import 'package:http/http.dart' as http;

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final Usercontroller _userController = Get.put(Usercontroller());
  final CommunityController _communityController =
      Get.put(CommunityController());

  final String backendUrl =
      'https://1e80-2405-4802-31-5060-697d-d3ba-2126-e634.ngrok-free.app'; // Biến môi trường
  bool isExpanded = false;

  int amount = 0;

  String note = '';

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'Sắp diễn ra':
        return Colors.yellow[100]!;
      case 'Đang diễn ra':
        return Colors.green[100]!;
      default:
        return Colors.pink[100]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Sắp diễn ra':
        return Colors.yellow[800]!;
      case 'Đang diễn ra':
        return Colors.green[800]!;
      default:
        return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thiện nguyện ánh sáng',
          style: kLableSize20w700Black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/svgs/upload.svg'),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        var community = _communityController.community.value!;
        String status = community.checkStatus();
        return SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 12),
            CachedNetworkImage(
              imageUrl: community.imageUrl,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator()), // Hiển thị trong khi tải
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Hiển thị khi có lỗi
              width: double.infinity,
              height: 300,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _getStatusBackgroundColor(status),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: _getStatusTextColor(status),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(community.communityName, style: kLableSize20w700Black),
                  const SizedBox(height: 8),
                  Text(
                    'Thông tin cộng đồng',
                    style: kLableSize18Black,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    community.description,
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: kLableSize15Grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Thu gọn' : 'Xem thêm',
                      style: const TextStyle(
                        color: AppColors.buleJeans,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Thông tin quyên góp',
                    style: kLableSize18Black,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      InputNumberField(
                          label: 'Số tiền',
                          name: '',
                          hinttext: '0đ',
                          onChanged: (value) {
                            amount = int.parse(value);
                          }),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      InputTextMultiline(
                          label: 'Nội dung',
                          name: '',
                          hinttext: 'Quyên góp cho quỹ từ thiện Trung Tính',
                          onChanged: (value) {
                            note = value;
                          }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ButtonBlue(
                    des: 'Quyên góp',
                    onPress: () async {
                      if (amount > 0 && note.isNotEmpty) {
                        final response = await http.get(
                          Uri.parse(
                              '$backendUrl/api/Vnpay/CreatePaymentUrl?money=$amount&description=$note&userId=${_userController.currentUser.value!.userId}&communityId=${community.communityId}'),
                        );

                        if (response.statusCode == 201) {
                          var url = response.body;
                          Get.to(() => PayDonation(
                                url: url,
                              ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Vui lòng nhập đủ thông tin!")),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ]),
        );
      }),
    );
  }
}
