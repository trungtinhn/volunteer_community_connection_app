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

  @override
  void initState() {
    super.initState();
    communityController.getCommunitiesEnded();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (communityController.communitiesEnd.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (communityController.communitiesEnd.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có hoạt động nào kết thúc.'),
        );
      }
      return ListView.builder(
        itemCount: communityController.communitiesEnd.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.communitiesEnd.value![index];
          double progress = 0.0;
          if (data.targetAmount != null) {
            progress = data.currentAmount / data.targetAmount!;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCard(
              status: 'Đã kết thúc',
              title: data.communityName,
              type: data.type,
              progress: progress,
              donationCount: data.donationCount,
              currentAmount: data.currentAmount,
              goalAmount: data.targetAmount ?? 0,
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
