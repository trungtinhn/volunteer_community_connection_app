import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/donation_card.dart';
import 'package:volunteer_community_connection_app/screens/donate/details_donation_screen.dart';

class EndTab extends StatefulWidget {
  const EndTab({super.key});

  @override
  State<EndTab> createState() => EndTabState();
}

class EndTabState extends State<EndTab> {
  final List<Map<String, dynamic>> donationData = [
    {
      "status": "Đã kết thúc",
      "title": "Hỗ trợ trẻ em mồ côi COVID-19",
      "subtitle": "Mang yêu thương đến trẻ em bị ảnh hưởng bởi đại dịch",
      "progress": 0.30,
      "donationCount": 200,
      "currentAmount": 100000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/covid_relief.jpg",
    },
    {
      "status": "Đã kết thúc",
      "title": "Hỗ trợ trẻ em mồ côi COVID-19",
      "subtitle": "Mang yêu thương đến trẻ em bị ảnh hưởng bởi đại dịch",
      "progress": 0.30,
      "donationCount": 200,
      "currentAmount": 100000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/covid_relief.jpg",
    },
    {
      "status": "Đã kết thúc",
      "title": "Hỗ trợ trẻ em mồ côi COVID-19",
      "subtitle": "Mang yêu thương đến trẻ em bị ảnh hưởng bởi đại dịch",
      "progress": 0.30,
      "donationCount": 200,
      "currentAmount": 100000000.0,
      "goalAmount": 100000000.0,
      "imageUrl": "assets/images/covid_relief.jpg",
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
