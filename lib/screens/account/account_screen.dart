import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/post_card.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/screens/home/detail_post_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'Bruno Pham',
      'timeAgo': '2 minutes ago',
      'description':
          'Chúng tôi đại diện BTC cộng đồng gây quỹ ánh sáng xin được phép kêu gọi quỹ mạnh thường quân hành động thiện nguyện tại tổ chức ...',
      'imageUrl': 'assets/images/covid_relief.jpg',
      'likes': 125,
      'comments': 50,
      'shares': 10,
    },
    {
      'username': 'Alice Nguyen',
      'timeAgo': '5 hours ago',
      'description':
          'Hãy tham gia chúng tôi trong chiến dịch mới này và giúp đỡ cộng đồng!',
      'imageUrl': 'assets/images/flood_relief.jpg',
      'likes': 200,
      'comments': 30,
      'shares': 12,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Ảnh đại diện
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
              const SizedBox(height: 10),

              // Tên và mô tả
              const Text(
                'Bruno Pham',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Sống một đời an nhiên và hạnh phúc',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Hàng thống kê
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatistic('140', 'Bài đăng'),
                  _buildStatistic('14.5K', 'Bạn bè'),
                  _buildStatistic('250K', 'Số lần quyên góp'),
                ],
              ),
              const SizedBox(height: 20),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(Icons.person_add, AppColors.darkBlue),
                  const SizedBox(width: 20),
                  _buildActionButton(Icons.email, Colors.blue),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  var post = posts[index];
                  return PostCard(
                    username: post['username'],
                    timeAgo: post['timeAgo'],
                    description: post['description'],
                    imageUrl: post['imageUrl'],
                    likes: post['likes'],
                    comments: post['comments'],
                    shares: post['shares'],
                    onTap: () {
                      Get.to(() => const DetailPostScreen());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng thống kê
  Widget _buildStatistic(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Hàm xây dựng nút hành động
  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
