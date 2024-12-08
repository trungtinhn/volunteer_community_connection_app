import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volunteer_community_connection_app/components/chat_item.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/screens/chat/detail_chat_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> chatData = [
    {
      "name": "Bryan",
      "message": "What do you think?",
      "time": "4:30 PM",
      "unreadCount": 2,
      "avatarUrl": "https://i.pravatar.cc/150?img=1",
    },
    {
      "name": "Kari",
      "message": "Looks great!",
      "time": "4:23 PM",
      "unreadCount": 1,
      "avatarUrl": "https://i.pravatar.cc/150?img=2",
    },
    {
      "name": "Diana",
      "message": "Lunch on Monday?",
      "time": "4:12 PM",
      "unreadCount": 0,
      "avatarUrl": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "Ben",
      "message": "You sent a photo.",
      "time": "3:58 PM",
      "unreadCount": 0,
      "avatarUrl": "https://i.pravatar.cc/150?img=4",
    },
    {
      "name": "Naomi",
      "message": "Naomi sent a photo.",
      "time": "3:31 PM",
      "unreadCount": 0,
      "avatarUrl": "https://i.pravatar.cc/150?img=5",
    },
    {
      "name": "Alicia",
      "message": "See you at 8.",
      "time": "3:30 PM",
      "unreadCount": 0,
      "avatarUrl": "https://i.pravatar.cc/150?img=6",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(
            child: ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                final chat = chatData[index];
                return ChatItem(
                  name: chat['name'],
                  message: chat['message'],
                  time: chat['time'],
                  unreadCount: chat['unreadCount'],
                  avatarUrl: chat['avatarUrl'],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailChatScreen()));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
