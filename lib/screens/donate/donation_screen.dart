import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      'https://11d3-2405-4802-31-5060-697d-d3ba-2126-e634.ngrok-free.app'; // Biến môi trường
  bool isExpanded = false;

  int amount = 0;

  String note = '';

  // Danh sách số tiền mặc định
  final List<int> predefinedAmounts = [
    5000,
    20000,
    50000,
    100000,
    200000,
    500000
  ];

  // Hàm kiểm tra số tiền hiện tại có được chọn không
  bool _isSelectedAmount(int value) => amount == value;

  bool isOtherAmountSelected = false; // Trạng thái chọn "Số tiền khác"

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
                  const SizedBox(height: 12),
                  // Hiển thị các ô chọn số tiền
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...predefinedAmounts.map((value) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              amount = value;
                              isOtherAmountSelected =
                                  false; // Bỏ chọn "Số tiền khác"
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: _isSelectedAmount(value)
                                  ? AppColors.buleJeans
                                  : AppColors.whitePorcelain,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _isSelectedAmount(value)
                                    ? AppColors.buleJeans
                                    : Colors.grey,
                              ),
                            ),
                            child: Text(
                                NumberFormat.decimalPattern('vi')
                                    .format(value), // Format số tiền
                                style: _isSelectedAmount(value)
                                    ? kLableSize15White
                                    : kLableSize15Black),
                          ),
                        );
                      }),
                      // Ô "Số tiền khác"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            amount = 0; // Xóa số tiền mặc định
                            isOtherAmountSelected = true; // Chọn "Số tiền khác"
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isOtherAmountSelected
                                ? AppColors.buleJeans
                                : AppColors.whitePorcelain,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isOtherAmountSelected
                                  ? AppColors.buleJeans
                                  : Colors.grey,
                            ),
                          ),
                          child: Text('Số tiền khác',
                              style: isOtherAmountSelected
                                  ? kLableSize15White
                                  : kLableSize15Black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Hiển thị trường nhập số tiền nếu chọn "Số tiền khác"
                  if (isOtherAmountSelected)
                    Row(
                      children: [
                        InputNumberField(
                          label: 'Nhập số tiền',
                          name: '',
                          hinttext: '0đ',
                          onChanged: (value) {
                            setState(() {
                              amount = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonBlue(
                        des: 'Quyên góp',
                        onPress: () async {
                          if (amount > 0 && note.isNotEmpty) {
                            final response = await http.get(
                              Uri.parse(
                                  '$backendUrl/api/Vnpay/CreatePaymentUrl?money=$amount&description=$note'),
                            );

                            if (response.statusCode == 201) {
                              var url = response.body;
                              Get.to(() => PayDonation(
                                    userId: _userController
                                        .currentUser.value!.userId,
                                    communityId: community.communityId,
                                    amount: amount,
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
                    ],
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
