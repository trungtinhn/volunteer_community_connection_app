import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/notification_item.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/notification_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/models/notification.dart';
import 'package:volunteer_community_connection_app/services/notification_service.dart';

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

  final NotificationService _notificationService = NotificationService();
  final Usercontroller _usercontroller = Get.put(Usercontroller());
  final NotificationController _notificationController =
      Get.put(NotificationController());

  Future<void> _initNotificationService() async {
    await _notificationService
        .initConnection(_usercontroller.getCurrentUser()!.userId);

    _notificationService.hubConnection.on('ReceiveNotification', (arguments) {
      final receiverId = arguments?[1];
      if (receiverId == _usercontroller.getCurrentUser()!.userId) {
        _getNotifications();
      }
    });
  }

  Future<void> _getNotifications() async {
    _notificationController.loadedNotifications.value =
        await _notificationController
            .getNotifications(_usercontroller.getCurrentUser()!.userId);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initNotificationService();
    _getNotifications();
  }

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
        body: Obx(() {
          return ListView.builder(
              itemCount: _notificationController.loadedNotifications.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final notification =
                    _notificationController.loadedNotifications[index];

                if (notification.type == 'POST') {
                  return NotificationItem(
                    avatarUrl: notification.avatarUrl!,
                    name: notification.userName!,
                    timeAgo: notification.timeAgo!,
                    content: notification.content!,
                    linkText: notification.title!,
                    postImageUrl: notification.imageUrl!,
                    onTap: () {},
                  );
                }
                return SizedBox();
              });
        }));
  }
}
