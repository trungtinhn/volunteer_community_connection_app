import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class ComingSoonTab extends StatefulWidget {
  const ComingSoonTab({super.key});

  @override
  State<ComingSoonTab> createState() => ComingSoonTabState();
}

class ComingSoonTabState extends State<ComingSoonTab> {
  final CommunityController communityController =
      Get.put(CommunityController());
  // final List<Map<String, dynamic>> donationData = [
  //   {
  //     "status": "Sắp diễn ra",
  //     "title": "Xây dựng trường học vùng cao",
  //     "subtitle": "Giúp trẻ em vùng cao có điều kiện học tập tốt hơn",
  //     "progress": 0.25,
  //     "donationCount": 50,
  //     "currentAmount": 25000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/school_building.jpg",
  //   },
  //   {
  //     "status": "Sắp diễn ra",
  //     "title": "Xây dựng trường học vùng cao",
  //     "subtitle": "Giúp trẻ em vùng cao có điều kiện học tập tốt hơn",
  //     "progress": 0.25,
  //     "donationCount": 50,
  //     "currentAmount": 25000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/school_building.jpg",
  //   },
  //   {
  //     "status": "Sắp diễn ra",
  //     "title": "Xây dựng trường học vùng cao",
  //     "subtitle": "Giúp trẻ em vùng cao có điều kiện học tập tốt hơn",
  //     "progress": 0.25,
  //     "donationCount": 50,
  //     "currentAmount": 25000000.0,
  //     "goalAmount": 100000000.0,
  //     "imageUrl": "assets/images/school_building.jpg",
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    communityController.getCommunitiesCommingSoon();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (communityController.communitiesComming.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (communityController.communitiesComming.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có hoạt động nào sắp diễn ra'),
        );
      }

      return ListView.builder(
        itemCount: communityController.communitiesComming.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.communitiesComming.value![index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCard(
              status: 'Sắp diễn ra',
              title: data.communityName,
              progress: 0,
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
