import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/models/notification.dart';
import 'package:volunteer_community_connection_app/repositories/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  Future<List<NotificationModel>> getNotifications(int userId) async {
    return await _notificationRepository.getNotifications(userId);
  }

  Future<void> createNotification(Map<String, dynamic> notification) async {
    await _notificationRepository.createNotification(notification);
  }
}
