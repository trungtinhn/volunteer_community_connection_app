import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/repositories/message_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/message.dart';

class MessageController extends GetxController {
  static final MessageController _instance = MessageController._internal();
  factory MessageController() => _instance;
  MessageController._internal();

  final MessageRepository _messageRepository = MessageRepository();

  RxList<Message> messages = <Message>[].obs;

  Future<void> getLatestMessages() async {
    timeago.setLocaleMessages('vi', timeago.ViMessages());

    var messages = await _messageRepository
        .getLatestMessages(Usercontroller().getCurrentUser()!.userId);

    for (var message in messages) {
      message.timeAgo = timeago.format(message.sentAt, locale: 'vi');
    }
    this.messages.value = messages;
  }

  Future<void> markMessageAsRead(int idUser, int otherIdUser) async {
    await _messageRepository.markMessageAsRead(idUser, otherIdUser);
  }

  Future<List<Message>> getChat(int idUser, int otherIdUser) async {
    return await _messageRepository.getChat(idUser, otherIdUser);
  }

  Future<void> sendMessage(Map<String, dynamic> data) async {
    await _messageRepository.sendMessage(data);
  }
}
