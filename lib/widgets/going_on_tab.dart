import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class GoingOnTab extends StatefulWidget {
  const GoingOnTab({super.key});

  @override
  State<GoingOnTab> createState() => GoingOnTabState();
}

class GoingOnTabState extends State<GoingOnTab> {
  final List<Map<String, dynamic>> donationData = [
    {
      "status": "Đang diễn ra",
      "title": "Cứu trợ lũ lụt miền Trung",
      "subtitle": "Ủng hộ đồng bào miền Trung vượt qua thiên tai",
      "progress": 0.65,
      "donationCount": 120,
      "currentAmount": 65000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/flood_relief.jpg",
    },
    {
      "status": "Đang diễn ra",
      "title": "Cứu trợ lũ lụt miền Trung",
      "subtitle": "Ủng hộ đồng bào miền Trung vượt qua thiên tai",
      "progress": 0.65,
      "donationCount": 120,
      "currentAmount": 65000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/flood_relief.jpg",
    },
    {
      "status": "Đang diễn ra",
      "title": "Cứu trợ lũ lụt miền Trung",
      "subtitle": "Ủng hộ đồng bào miền Trung vượt qua thiên tai",
      "progress": 0.65,
      "donationCount": 120,
      "currentAmount": 65000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/flood_relief.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: donationData.length,
      itemBuilder: (context, index) {
        final data = donationData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: DonationCard(
            status: data['status'],
            title: data['title'],
            subtitle: data['subtitle'],
            progress: data['progress'],
            donationCount: data['donationCount'],
            currentAmount: data['currentAmount'],
            goalAmount: data['goalAmount'],
            imageUrl: data['imageUrl'],
            onDetails: () {
              Get.to(() => const DetailsDonationScreen());
            },
            onDonate: () {},
          ),
        );
      },
    );
  }
}
