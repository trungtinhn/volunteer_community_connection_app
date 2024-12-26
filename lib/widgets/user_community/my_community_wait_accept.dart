import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/components/donation_card_wait_accept.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class MyCommunityWaitAcceptTab extends StatefulWidget {
  const MyCommunityWaitAcceptTab({super.key});

  @override
  State<MyCommunityWaitAcceptTab> createState() =>
      _MyCommunityWaitAcceptTabState();
}

class _MyCommunityWaitAcceptTabState extends State<MyCommunityWaitAcceptTab> {
  CommunityController communityController = Get.put(CommunityController());
  Usercontroller userController = Get.put(Usercontroller());
  @override
  void initState() {
    super.initState();
    communityController
        .getMyCommunitiesNoPublic(userController.currentUser.value!.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (communityController.myCommunitiesNoPublic.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (communityController.myCommunitiesNoPublic.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có hoạt động nào đang chờ duyệt.'),
        );
      }
      return ListView.builder(
        itemCount: communityController.myCommunitiesNoPublic.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.myCommunitiesNoPublic.value![index];
          double progress = 0.0;
          if (data.targetAmount != null) {
            progress = data.currentAmount / data.targetAmount!;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCardWaitAccept(
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
              onAccept: () {},
              onDeny: () {},
              role: userController.currentUser.value!.role,
            ),
          );
        },
      );
    });
  }
}
