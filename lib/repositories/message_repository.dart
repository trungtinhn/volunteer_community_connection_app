import 'package:volunteer_community_connection_app/models/message.dart';

import '../services/api_service.dart';

class MessageRepository {
  final ApiService _apiService = ApiService();

  Future<List<Message>> getLatestMessages(int idUser) async {
    final data =
        await _apiService.getAll('/api/Message/get-latest-messages/$idUser');
    return List<Message>.from(data.map((e) => Message.fromJson(e))).toList();
  }

  Future<void> markMessageAsRead(int idUser, int otherIdUser) async {
    await _apiService.post(
        '/api/Message/mark-messages-is-read/$idUser-$otherIdUser', null);
  }

  Future<List<Message>> getChat(int idUser, int otherIdUser) async {
    final data =
        await _apiService.getAll('/api/Message/chat/$idUser/$otherIdUser');

    return List<Message>.from(data.map((e) => Message.fromJson(e))).toList();
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> data) async {
    var result = await _apiService.post('/api/Message', data);

    return result;
  }
}
