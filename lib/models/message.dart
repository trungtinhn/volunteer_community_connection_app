class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime sentAt;
  final bool isRead;
  final int unreadCount;
  final String userName;
  final String avatarUrl;
  late String? timeAgo;
  final String? imageUrl;

  Message(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.content,
      required this.sentAt,
      required this.isRead,
      required this.unreadCount,
      required this.userName,
      required this.avatarUrl,
      required this.imageUrl});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      sentAt: DateTime.parse(json['sentAt']),
      isRead: json['isRead'],
      unreadCount: json['unreadCount'],
      userName: json['userName'],
      avatarUrl: json['avatarUrl'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'sentAt': sentAt.toIso8601String(),
      'isRead': isRead,
      'unreadCount': unreadCount,
      'userName': userName,
      'avatarUrl': avatarUrl,
      'imageUrl': imageUrl
    };
  }
}
