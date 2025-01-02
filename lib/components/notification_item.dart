import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class NotificationItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String timeAgo;
  final String content;
  final String linkText;
  final String postImageUrl;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.timeAgo,
    required this.content,
    required this.linkText,
    required this.postImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên người dùng và thời gian
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name, style: kLabelSize15Blackw600),
                        Text(
                          timeAgo,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Nội dung và liên kết
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: content, style: kLableSize15Black),
                          TextSpan(text: ' ', style: kLableSize15Black),
                          TextSpan(text: linkText, style: kLableSize15Bluew600),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Ảnh bài đăng
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  postImageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
