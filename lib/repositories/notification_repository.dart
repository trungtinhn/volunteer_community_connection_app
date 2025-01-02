import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/models/notification.dart';
import 'package:volunteer_community_connection_app/services/api_service.dart';

class NotificationRepository {
  final ApiService _apiService = ApiService();

  Future<List<NotificationModel>> getNotifications(int userId) async {
    final data = await _apiService.getAll('/api/Notification/$userId');
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  Future<void> createNotification(Map<String, dynamic> notification) async {
    await _apiService.post('/api/Notification', notification);
  }
}
