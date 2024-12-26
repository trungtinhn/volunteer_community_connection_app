import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/rank_card.dart';
import 'package:volunteer_community_connection_app/components/top_three_rank.dart';
import 'package:volunteer_community_connection_app/controllers/donation_controller.dart';
import 'package:volunteer_community_connection_app/models/community.dart';

class DonorTab extends StatefulWidget {
  final Community community;
  const DonorTab({super.key, required this.community});

  @override
  State<DonorTab> createState() => DonorTabState();
}

class DonorTabState extends State<DonorTab> {
  final DonationController _donationController = Get.put(DonationController());

  final List<Map<String, dynamic>> leaderboardData = [
    {
      'rank': 1,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Nguyễn A',
      'amount': '100.000đ',
    },
    {
      'rank': 2,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Nguyễn B',
      'amount': '100.000đ',
    },
    {
      'rank': 3,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Nguyễn C',
      'amount': '100.000đ',
    },
    {
      'rank': 4,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Thạch Sang',
      'amount': '100.000đ',
    },
    {
      'rank': 5,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Lý Thông',
      'amount': '90.000đ',
    },
    {
      'rank': 6,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Mai Lan',
      'amount': '85.000đ',
    },
    {
      'rank': 7,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Phạm Hưng',
      'amount': '80.000đ',
    },
    {
      'rank': 8,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Hải Đăng',
      'amount': '75.000đ',
    },
    {
      'rank': 9,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Hoàng Yến',
      'amount': '70.000đ',
    },
    {
      'rank': 10,
      'avatar': 'assets/images/flood_relief.jpg',
      'name': 'Thanh Sơn',
      'amount': '65.000đ',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadContributors();
  }

  Future<void> loadContributors() async {
    _donationController.loadedDonations.value =
        await _donationController.getContributors(widget.community.communityId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Obx(
          () => Top3Component(top3: _donationController.loadedDonations.value),
        ),
        const SizedBox(height: 16),
        if (_donationController.loadedDonations.length > 3)
          Obx(
            () => Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: _donationController.loadedDonations.length -
                    3, // Bỏ qua Top 3
                itemBuilder: (context, index) {
                  final data = _donationController
                      .loadedDonations[index + 3]; // Lấy dữ liệu từ hạng 4
                  return RankCard(
                    rank: index + 3,
                    avatar: data.avatarUrl,
                    name: data.userName,
                    amount: data.amount,
                    isEven:
                        (index + 3) % 2 == 0, // Xen kẽ màu dựa trên vị trí thực
                  );
                },
              ),
            ),
          )
      ],
    );
  }
}
