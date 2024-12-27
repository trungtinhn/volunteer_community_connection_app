class NotificationModel {
  final String notificationId;
  final String? title;
  final String? content;
  final int userId;
  final int senderId;
  final DateTime createdAt;
  final bool isRead;
  final String type;
  final int communityId;
  final int postId;
  final String? userName;
  final String? avatarUrl;
  final String? imageUrl;

  NotificationModel(
      {required this.notificationId,
      this.title,
      this.content,
      required this.userId,
      required this.senderId,
      required this.createdAt,
      required this.isRead,
      required this.type,
      required this.communityId,
      required this.postId,
      this.userName,
      this.avatarUrl,
      this.imageUrl});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'],
      title: json['title'],
      content: json['content'],
      userId: json['userId'],
      senderId: json['senderId'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
      type: json['type'],
      communityId: json['communityId'],
      postId: json['postId'],
      userName: json['userName'],
      avatarUrl: json['avatarUrl'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'title': title,
        'content': content,
        'userId': userId,
        'senderId': senderId,
        'createdAt': createdAt.toIso8601String(),
        'isRead': isRead,
        'type': type,
        'communityId': communityId,
        'postId': postId,
        'userName': userName,
        'avatarUrl': avatarUrl,
        'imageUrl': imageUrl
      };
}
