import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class EndTab extends StatefulWidget {
  const EndTab({super.key});

  @override
  State<EndTab> createState() => EndTabState();
}

class EndTabState extends State<EndTab> {
  final CommunityController communityController =
      Get.put(CommunityController());

  // final List<Map<String, dynamic>> donationData = [
  //   {
  //     "status": "Đã kết thúc",
  //     "title": "Hỗ trợ trẻ em mồ côi COVID-19",
  //     "subtitle": "Mang yêu thương đến trẻ em bị ảnh hưởng bởi đại dịch",
  //     "progress": 0.30,
  //     "donationCount": 200,
  //     "currentAmount": 100000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/covid_relief.jpg",
  //   },
  //   {
  //     "status": "Đã kết thúc",
  //     "title": "Hỗ trợ trẻ em mồ côi COVID-19",
  //     "subtitle": "Mang yêu thương đến trẻ em bị ảnh hưởng bởi đại dịch",
  //     "progress": 0.30,
  //     "donationCount": 200,
  //     "currentAmount": 100000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/covid_relief.jpg",
  //   },
  //   {
  //     "status": "Đã kết thúc",
  //     "title": "Hỗ trợ trẻ em mồ côi COVID-19",
  //     "subtitle": "Mang yêu thương đến trẻ em bị ảnh hưởng bởi đại dịch",
  //     "progress": 0.30,
  //     "donationCount": 200,
  //     "currentAmount": 100000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/covid_relief.jpg",
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    communityController.getCommunitiesEnded();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(communityController.communitiesEnd.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if(communityController.communitiesEnd.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có hoạt động nào kết thúc.'),
        );
      }
      return ListView.builder(
        itemCount: communityController.communitiesEnd.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.communitiesEnd.value![index];
          double progress = data.currentAmount / data.targetAmount;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCard(
              status: 'Đã kết thúc',
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
