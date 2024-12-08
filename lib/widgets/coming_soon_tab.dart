import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class ComingSoonTab extends StatefulWidget {
  const ComingSoonTab({super.key});

  @override
  State<ComingSoonTab> createState() => ComingSoonTabState();
}

class ComingSoonTabState extends State<ComingSoonTab> {
  final List<Map<String, dynamic>> donationData = [
    {
      "status": "Sắp diễn ra",
      "title": "Xây dựng trường học vùng cao",
      "subtitle": "Giúp trẻ em vùng cao có điều kiện học tập tốt hơn",
      "progress": 0.25,
      "donationCount": 50,
      "currentAmount": 25000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/school_building.jpg",
    },
    {
      "status": "Sắp diễn ra",
      "title": "Xây dựng trường học vùng cao",
      "subtitle": "Giúp trẻ em vùng cao có điều kiện học tập tốt hơn",
      "progress": 0.25,
      "donationCount": 50,
      "currentAmount": 25000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/school_building.jpg",
    },
    {
      "status": "Sắp diễn ra",
      "title": "Xây dựng trường học vùng cao",
      "subtitle": "Giúp trẻ em vùng cao có điều kiện học tập tốt hơn",
      "progress": 0.25,
      "donationCount": 50,
      "currentAmount": 25000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/school_building.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: donationData.length,
      itemBuilder: (context, index) {
        final data = donationData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
