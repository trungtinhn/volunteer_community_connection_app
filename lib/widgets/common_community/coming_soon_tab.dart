import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class ComingSoonTab extends StatefulWidget {
  const ComingSoonTab({super.key});

  @override
  State<ComingSoonTab> createState() => ComingSoonTabState();
}

class ComingSoonTabState extends State<ComingSoonTab> {
  final CommunityController communityController =
      Get.put(CommunityController());

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
              status: data.checkStatus(),
              title: data.communityName,
              type: data.type,
              description: data.description,
              startDate: formatDate(data.startDate),
              endDate: formatDate(data.endDate),
              progress: 0,
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
