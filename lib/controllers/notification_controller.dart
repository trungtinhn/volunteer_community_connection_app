import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/models/notification.dart';
import 'package:volunteer_community_connection_app/repositories/notification_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  RxList<NotificationModel> loadedNotifications = RxList<NotificationModel>();

  Future<List<NotificationModel>> getNotifications(int userId) async {
    var notifications = await _notificationRepository.getNotifications(userId);

    for (var notification in notifications) {
      notification.timeAgo =
          timeago.format(notification.createdAt, locale: 'vi');
    }

    return notifications;
  }

  Future<void> createNotification(Map<String, dynamic> notification) async {
    await _notificationRepository.createNotification(notification);
  }
}
