import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/components/notification_item.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      "avatarUrl": "https://i.pravatar.cc/150?img=1",
      "name": "Người dùng 1",
      "timeAgo": "2 phút trước",
      "content": "Đã thích bài đăng tại ",
      "linkText": "Hoạt động thiện nguyện",
      "postImageUrl": "https://picsum.photos/200/200?random=1",
    },
    {
      "avatarUrl": "https://i.pravatar.cc/150?img=2",
      "name": "Người dùng 2",
      "timeAgo": "5 phút trước",
      "content": "Đã thích bài đăng tại ",
      "linkText": "Hỗ trợ đồng bào",
      "postImageUrl": "https://picsum.photos/200/200?random=2",
    },
    {
      "avatarUrl": "https://i.pravatar.cc/150?img=3",
      "name": "Người dùng 3",
      "timeAgo": "10 phút trước",
      "content": "Đã thích bài đăng tại ",
      "linkText": "Từ thiện mùa đông",
      "postImageUrl": "https://picsum.photos/200/200?random=3",
    },
    {
      "avatarUrl": "https://i.pravatar.cc/150?img=1",
      "name": "Người dùng 1",
      "timeAgo": "2 phút trước",
      "content": "Đã thích bài đăng tại ",
      "linkText": "Hoạt động thiện nguyện",
      "postImageUrl": "https://picsum.photos/200/200?random=1",
    },
    {
      "avatarUrl": "https://i.pravatar.cc/150?img=2",
      "name": "Người dùng 2",
      "timeAgo": "5 phút trước",
      "content": "Đã thích bài đăng tại ",
      "linkText": "Hỗ trợ đồng bào",
      "postImageUrl": "https://picsum.photos/200/200?random=2",
    },
    {
      "avatarUrl": "https://i.pravatar.cc/150?img=3",
      "name": "Người dùng 3",
      "timeAgo": "10 phút trước",
      "content": "Đã thích bài đăng tại ",
      "linkText": "Từ thiện mùa đông",
      "postImageUrl": "https://picsum.photos/200/200?random=3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Thông báo',
            style: kLableSize20w700Black,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: notifications.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return NotificationItem(
                avatarUrl: notification['avatarUrl'],
                name: notification['name'],
                timeAgo: notification['timeAgo'],
                content: notification['content'],
                linkText: notification['linkText'],
                postImageUrl: notification['postImageUrl'],
                onTap: () {},
              );
            }));
  }
}
