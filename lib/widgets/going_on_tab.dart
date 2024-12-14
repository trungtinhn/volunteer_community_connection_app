import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class GoingOnTab extends StatefulWidget {
  const GoingOnTab({super.key});

  @override
  State<GoingOnTab> createState() => GoingOnTabState();
}

class GoingOnTabState extends State<GoingOnTab> {
  CommunityController communityController = Get.put(CommunityController());

  // final List<Map<String, dynamic>> donationData = [
  //   {
  //     "status": "Đang diễn ra",
  //     "title": "Cứu trợ lũ lụt miền Trung",
  //     "subtitle": "Ủng hộ đồng bào miền Trung vượt qua thiên tai",
  //     "progress": 0.65,
  //     "donationCount": 120,
  //     "currentAmount": 65000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/flood_relief.jpg",
  //   },
  //   {
  //     "status": "Đang diễn ra",
  //     "title": "Cứu trợ lũ lụt miền Trung",
  //     "subtitle": "Ủng hộ đồng bào miền Trung vượt qua thiên tai",
  //     "progress": 0.65,
  //     "donationCount": 120,
  //     "currentAmount": 65000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/flood_relief.jpg",
  //   },
  //   {
  //     "status": "Đang diễn ra",
  //     "title": "Cứu trợ lũ lụt miền Trung",
  //     "subtitle": "Ủng hộ đồng bào miền Trung vượt qua thiên tai",
  //     "progress": 0.65,
  //     "donationCount": 120,
  //     "currentAmount": 65000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/flood_relief.jpg",
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    communityController.getCommunitiesGoingOn();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Kiểm tra nếu dữ liệu chưa được tải
      if (communityController.communitiesGoing.value == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Nếu không có dữ liệu
      if (communityController.communitiesGoing.value!.isEmpty) {
        return const Center(
          child: Text('Hiện không có hoạt động nào đang diễn ra'),
        );
      }

      return ListView.builder(
        itemCount: communityController.communitiesGoing.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.communitiesGoing.value![index];
          double progress = data.currentAmount / data.targetAmount;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: DonationCard(
              status: 'Đang diễn ra',
              title: data.communityName,
              progress: progress,
              donationCount: data.donationCount,
              currentAmount: data.currentAmount,
              goalAmount: data.targetAmount,
              imageUrl: data.imageUrl,
              onDetails: () {
                Get.to(() => const DetailsDonationScreen());
              },
              onDonate: () {},
            ),
          );
        },
      );
    });
  }
}
