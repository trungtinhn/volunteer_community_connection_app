import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card_wait_accept.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class CommunityRejected extends StatefulWidget {
  const CommunityRejected({super.key});

  @override
  State<CommunityRejected> createState() => _CommunityRejectedState();
}

class _CommunityRejectedState extends State<CommunityRejected> {
  CommunityController communityController = Get.put(CommunityController());
  Usercontroller user = Get.put(Usercontroller());

  @override
  void initState() {
    super.initState();
    communityController.getCommnitiesRejected();
  }

  // Hiển thị thông báo
  void _showMessage(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (communityController.communitiesRejected.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (communityController.communitiesRejected.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có hoạt động nào bị từ chối.'),
        );
      }
      return ListView.builder(
        itemCount: communityController.communitiesRejected.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.communitiesRejected.value![index];
          double progress = 0.0;
          if (data.targetAmount != null) {
            progress = data.currentAmount / data.targetAmount!;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCardWaitAccept(
              status: 'Đã bị từ chối',
              title: data.communityName,
              type: data.type,
              role: user.currentUser.value!.role,
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
              onAccept: () async {},
              onDeny: () {},
            ),
          );
        },
      );
    });
  }
}
