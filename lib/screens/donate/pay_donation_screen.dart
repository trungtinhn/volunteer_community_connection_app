import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class PayDonation extends StatefulWidget {
  const PayDonation({super.key});

  @override
  State<PayDonation> createState() => _PayDonationState();
}

class _PayDonationState extends State<PayDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quyên góp',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImageView(
            data: 'This is a simple QR code',
            version: QrVersions.auto,
            size: 230,
            gapless: false,
          ),
          buildInfoRow('Cộng đồng:', 'Thiện nguyện ánh sáng'),
          buildInfoRow('Số tiền:', '100.000đ'),
          buildInfoRow('Nội dung:', 'Chung tay góp sức thiện nguyện'),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ButtonBlue(des: 'Thanh toán', onPress: () {}),
          )
        ],
      ),
    );
  }

  Widget buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kLabelSize15Blackw600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(content, style: kLableSize15Black),
          ),
        ],
      ),
    );
  }
}
