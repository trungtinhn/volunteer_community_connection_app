import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card_wait_accept.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class CommunityWaitAccept extends StatefulWidget {
  const CommunityWaitAccept({super.key});

  @override
  State<CommunityWaitAccept> createState() => _CommunityWaitAcceptState();
}

class _CommunityWaitAcceptState extends State<CommunityWaitAccept> {
  CommunityController communityController = Get.put(CommunityController());
  Usercontroller user = Get.put(Usercontroller());

  @override
  void initState() {
    super.initState();
    communityController.getCommunitiesNoPublic();
  }

  // Hiển thị thông báo
  void _showMessage(String message, {bool isSuccess = false}) {
    Get.snackbar(
      'Thông báo',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (communityController.communitiesNoPublic.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (communityController.communitiesNoPublic.value!.isEmpty) {
        return const Center(
          child: Text('Hiện tại không có hoạt động nào đang chờ duyệt.'),
        );
      }
      return ListView.builder(
        itemCount: communityController.communitiesNoPublic.value!.length,
        itemBuilder: (context, index) {
          final data = communityController.communitiesNoPublic.value![index];
          double progress = 0.0;
          if (data.targetAmount != null) {
            progress = data.currentAmount / data.targetAmount!;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DonationCardWaitAccept(
              status: 'Đang chờ duyệt',
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
              onAccept: () async {
                var result = await communityController
                    .publishCommunity(data.communityId);
                if (result) {
                  _showMessage('Duyệt dự án thành công.', isSuccess: true);
                  communityController.getCommunitiesNoPublic();
                } else {
                  _showMessage('Duyệt dự án thất bại.', isSuccess: false);
                }
              },
              onDeny: () async {
                var result =
                    await communityController.rejectCommunity(data.communityId);
                if (result) {
                  _showMessage('Từ chối dự án thành công.', isSuccess: true);
                  communityController.getCommunitiesNoPublic();
                } else {
                  _showMessage('Từ chối dự án thất bại.', isSuccess: false);
                }
              },
            ),
          );
        },
      );
    });
  }
}
