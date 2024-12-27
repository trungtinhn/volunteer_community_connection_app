import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:volunteer_community_connection_app/components/chat_item.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/message_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/models/message.dart';
import 'package:volunteer_community_connection_app/screens/chat/detail_chat_screen.dart';
import 'package:volunteer_community_connection_app/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();

  final Usercontroller _userController = Get.put(Usercontroller());

  final MessageController _messageController = Get.put(MessageController());

  Future<void> _initChatService() async {
    await _chatService.initConnection(_userController.getCurrentUser()!.userId);

    _chatService.hubConnection.on('ReceiveMessage', (arguments) {
      final receiverId = arguments?[1];

      if (receiverId == _userController.getCurrentUser()!.userId) {
        _messageController.getLatestMessages();
      }
      // print(
      //     'Message received: SenderId=${arguments?[0]}, Content=${arguments?[1]}, SentAt=${arguments?[2]}');

      // _messageController.getLatestMessages();
    });
  }

  Future<void> _intListMessage() async {
    _messageController.getLatestMessages();
  }

  @override
  void initState() {
    super.initState();
    _initChatService();
    _intListMessage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _messageController.getLatestMessages();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Chats",
            style: kLableSize20w700Black,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF1F8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/search.svg'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontFamily: 'CeraPro',
                            color: AppColors.greyIron,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Chat list
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: _messageController.messages.length,
                  itemBuilder: (context, index) {
                    final message = _messageController.messages[index];
                    return ChatItem(
                      name: message.userName,
                      message: message.content,
                      time: message.timeAgo!,
                      unreadCount: message.unreadCount,
                      avatarUrl: message.avatarUrl,
                      onTap: () {
                        _messageController.markMessageAsRead(
                            _userController.getCurrentUser()!.userId,
                            message.senderId ==
                                    _userController.getCurrentUser()!.userId
                                ? message.receiverId
                                : message.senderId);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailChatScreen(
                                      message: message,
                                    ))).then((value) {
                          _messageController.getLatestMessages();
                        });
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
