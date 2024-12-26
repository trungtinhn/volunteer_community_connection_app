import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class MyCommunityTab extends StatefulWidget {
  const MyCommunityTab({super.key});

  @override
  State<MyCommunityTab> createState() => _MyCommunityTabState();
}

class _MyCommunityTabState extends State<MyCommunityTab> {
  CommunityController communityController = Get.put(CommunityController());
  Usercontroller userController = Get.put(Usercontroller());

  @override
  void initState() {
    super.initState();
    communityController
        .getMyCommunities(userController.currentUser.value!.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (communityController.myCommunities.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (communityController.myCommunities.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có dự án nào của bạn đang diễn ra.'),
        );
      }
      return ListView.builder(
        itemCount: communityController.myCommunities.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.myCommunities.value![index];
          double progress = 0.0;
          if (data.targetAmount != null) {
            progress = data.currentAmount / data.targetAmount!;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCard(
              status: data.checkStatus(),
              title: data.communityName,
              type: data.type,
              description: data.description,
              startDate: formatDate(data.startDate),
              endDate: formatDate(data.endDate),
              progress: progress,
              donationCount: data.donationCount,
              currentAmount: data.currentAmount,
              goalAmount: data.targetAmount ?? 0,
              imageUrl: data.imageUrl,
              onDetails: () {
                Get.to(() => DetailsDonationScreen(
                      communityId: data.communityId,
                    ));
              },
              onDonate: () {},
            ),
          );
        },
      );
    });
  }
}
