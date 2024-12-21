class Comment {
  final int commentId;
  final String content;
  final int userId;
  final int postId;
  final DateTime createDate;
  final int? parentCommentId;
  final String userName;
  final String? avatarUrl;
  late String timeAgo;

  Comment({
    required this.commentId,
    required this.content,
    required this.userId,
    required this.postId,
    required this.createDate,
    this.parentCommentId,
    required this.userName,
    this.avatarUrl,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      content: json['content'],
      userId: json['userId'],
      postId: json['postId'],
      createDate: DateTime.parse(json['createDate']),
      parentCommentId: json['parentCommentId'],
      userName: json['userName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'content': content,
        'userId': userId,
        'postId': postId,
        'createDate': createDate.toIso8601String(),
        'parentCommentId': parentCommentId,
        'userName': userName,
        'avatarUrl': avatarUrl,
      };
}
