import 'dart:io';

import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/message_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/message.dart';
import '../../services/chat_service.dart';

class DetailChatScreen extends StatefulWidget {
  final Message message;
  const DetailChatScreen({super.key, required this.message});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  final ChatService _chatService = ChatService();
  List<Message> messages = [];

  final MessageController _messageController = MessageController();
  final Usercontroller _usercontroller = Usercontroller();
  final TextEditingController _textEditingController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image picker error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getChat();
    _initChatService();
  }

  Future<void> _initChatService() async {
    await _chatService.initConnection(_usercontroller.getCurrentUser()!.userId);

    _chatService.hubConnection.on('ReceiveMessage', (arguments) {
      final receiverId = arguments?[1];
      final senderId = arguments?[0];

      if (receiverId == _usercontroller.getCurrentUser()!.userId &&
          senderId ==
              (widget.message.senderId ==
                      _usercontroller.getCurrentUser()!.userId
                  ? widget.message.receiverId
                  : widget.message.senderId)) {
        _messageController.getLatestMessages();
        _getChat();
      }
    });
  }

  Future<void> _sendMessage(String message) async {
    if (_selectedImage == null) {
      await _chatService.sendMessage(
          _usercontroller.getCurrentUser()!.userId,
          widget.message.senderId == _usercontroller.getCurrentUser()!.userId
              ? widget.message.receiverId
              : widget.message.senderId,
          message);
    } else {
      await _chatService.sendMessageWithImage(
        _usercontroller.getCurrentUser()!.userId,
        widget.message.senderId == _usercontroller.getCurrentUser()!.userId
            ? widget.message.receiverId
            : widget.message.senderId,
        _selectedImage!,
      );

      _selectedImage = null;
    }

    _getChat();
  }

  Future<void> _getChat() async {
    messages = await _messageController.getChat(
        widget.message.senderId, widget.message.receiverId);
    setState(() {});
  }

  final List<Map<String, dynamic>> messages1 = [
    {
      'sender': 'Bryan',
      'message': 'Looking forward to the trip.',
      'isMe': false,
      'time': '8:40 AM',
    },
    {
      'sender': 'Me',
      'message': 'Same! Can’t wait.',
      'isMe': true,
      'time': '8:41 AM',
    },
    {
      'sender': 'Bryan',
      'imageUrl': 'https://via.placeholder.com/300',
      'isMe': false,
      'time': '8:43 AM',
    },
    {
      'sender': 'Bryan',
      'message': 'What do you think?',
      'isMe': false,
      'time': '8:44 AM',
    },
    {
      'sender': 'Me',
      'message': 'Oh yes this looks great!',
      'isMe': true,
      'time': '8:45 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.message.userName,
          style: kLableSize15Black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                // if (message.containsKey('imageUrl')) {
                //   return _buildMessageImage(
                //     avatar: !message['isMe'],
                //     imageUrl: message['imageUrl'],
                //   );
                // } else {
                //   return _buildMessageBubble(
                //     avatar: !message['isMe'],
                //     message: message['message'],
                //     isMe: message['isMe'],
                //   );
                // }

                if (message.imageUrl != null) {
                  return _buildMessageImage(
                    imageUrl: message.imageUrl!,
                    isMe: message.senderId ==
                        _usercontroller.getCurrentUser()!.userId,
                    haveAvatar: !(message.senderId ==
                        _usercontroller.getCurrentUser()!.userId),
                    avatarUrl: message.avatarUrl,
                  );
                } else {
                  return _buildMessageBubble(
                    avatarUrl: widget.message.avatarUrl,
                    haveAvatar: !(message.senderId ==
                        _usercontroller.getCurrentUser()!.userId),
                    message: message.content,
                    isMe: message.senderId ==
                        _usercontroller.getCurrentUser()!.userId,
                  );
                }
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  // Hàm tạo tin nhắn dạng văn bản
  Widget _buildMessageBubble({
    required String message,
    required bool isMe,
    bool haveAvatar = false,
    required String avatarUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe && haveAvatar)
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatarUrl), // Thay bằng ảnh thực tế
          ),
        if (!isMe && haveAvatar) const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isMe ? 12 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 12),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // Hàm tạo tin nhắn dạng hình ảnh
  Widget _buildMessageImage({
    required String imageUrl,
    bool haveAvatar = false,
    required bool isMe,
    required String avatarUrl,
  }) {
    return Row(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isMe && haveAvatar)
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatarUrl),
          ),
        if (haveAvatar) const SizedBox(width: 10),
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
            ),
          ],
        ),
      ],
    );
  }

  // Hàm tạo thanh nhập tin nhắn
  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
          if (_selectedImage != null)
            Expanded(
                child: Stack(
              children: [
                Image.file(
                  _selectedImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                  ),
                ),
              ],
            )),
          if (_selectedImage == null)
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendMessage(_textEditingController.text);
              _textEditingController.clear();
            },
          ),
        ],
      ),
    );
  }
}
