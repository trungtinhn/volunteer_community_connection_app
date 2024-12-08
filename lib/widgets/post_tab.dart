import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volunteer_community_connection_app/components/post_card.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/screens/home/create_post_screen.dart';
import 'package:volunteer_community_connection_app/screens/home/detail_post_screen.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => PostTabState();
}

class PostTabState extends State<PostTab> {
  // Dữ liệu mẫu cho các bài viết
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chia sẻ bài đăng', style: kLableSize18Black),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/image_sample.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePostScreen(),
                    ),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.greyIron, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Chia sẻ của nghĩ của bạn về dự án',
                        style: kLableSize15Grey,
                      ),
                    )),
              )
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailPostScreen(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
