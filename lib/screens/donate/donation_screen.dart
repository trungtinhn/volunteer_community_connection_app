import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/components/input_number.dart';
import 'package:volunteer_community_connection_app/components/input_text_multiline.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/screens/donate/pay_donation_screen.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  String imageUrl = 'assets/images/covid_relief.jpg';
  String title = 'Đồ dùng cho người khuỷu hoạch';
  int donationCount = 5;
  int currentAmount = 10000;
  int goalAmount = 20000;
  String status = 'Đang diễn ra';
  String description =
      'Bạn hẳn sẽ không cầm lòng nổi khi biết ở vùng cao, vùng sâu, vùng xa có hàng trăm, hàng ngàn đồng bào của chúng ta đang sống cuộc sống nghèo khó, thiếu thốn. Người già, trẻ em không có nổi tấm chăn, manh áo ấm; các gia đình lay lắt bên những mái nhà xuống cấp không đủ che gió, che mưa; biết bao em bé không có sách để đọc, không có quyển vở cây bút để viết, thậm chí có em không được đến trường. Với mong muốn những cảnh đời khó khăn sẽ được sưởi ấm bằng những món quà tuy nhỏ nhưng tràn đầy tình yêu thương, tràn đầy hơi ấm tình người, Trung tâm Tư vấn pháp luật phối hợp với BCH Công đoàn Học viện Tư pháp kêu gọi những tấm lòng nhân ái tham gia chương trình quyên góp, hỗ trợ, đóng góp về tinh thần và vật chất cho các chương trình từ thiện.';
  bool isExpanded = false;

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
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 12),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width - 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
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
                Text(title, style: kLableSize20w700Black),
                const SizedBox(height: 8),
                Text(
                  'Thông tin cộng đồng',
                  style: kLableSize18Black,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: isExpanded ? null : 3,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
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
                        onChanged: (value) {}),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    InputTextMultiline(
                        label: 'Nội dung',
                        name: '',
                        hinttext: 'Quyên góp cho quỹ từ thiện Trung Tính',
                        onChanged: (value) {}),
                  ],
                ),
                const SizedBox(height: 16),
                ButtonBlue(
                    des: 'Quyên góp',
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PayDonation(),
                        ),
                      );
                    }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
