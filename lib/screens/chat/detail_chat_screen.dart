import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({super.key});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  final List<Map<String, dynamic>> messages = [
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
          'Bryan',
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
                if (message.containsKey('imageUrl')) {
                  return _buildMessageImage(
                    avatar: !message['isMe'],
                    imageUrl: message['imageUrl'],
                  );
                } else {
                  return _buildMessageBubble(
                    avatar: !message['isMe'],
                    message: message['message'],
                    isMe: message['isMe'],
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
    bool avatar = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe && avatar)
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), // Thay bằng ảnh thực tế
          ),
        if (!isMe && avatar) const SizedBox(width: 10),
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
    bool avatar = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (avatar)
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
        if (avatar) const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/splash1.png',
                  fit: BoxFit.fill,
                ),
              ),
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
            onPressed: () {},
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
