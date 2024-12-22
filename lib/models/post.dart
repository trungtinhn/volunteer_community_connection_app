class Post {
  final int postId;
  final String title;
  final String content;
  final int userId;
  final int communityID;
  final DateTime createDate;
  final String? imageUrl;
  final int likeCount;
  final int commentCount;
  final String userName;
  final String? avatarUrl;
  bool isLiked = false;
  late String? timeAgo;

  Post(
      {required this.postId,
      required this.title,
      required this.content,
      required this.userId,
      required this.communityID,
      required this.createDate,
      required this.imageUrl,
      required this.likeCount,
      required this.commentCount,
      required this.userName,
      required this.avatarUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      title: json['title'],
      content: json['content'],
      userId: json['userId'],
      communityID: json['communityID'],
      createDate: DateTime.parse(json['createDate']),
      imageUrl: json['imageUrl'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      userName: json['userName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'title': title,
      'content': content,
      'userId': userId,
      'communityID': communityID,
      'createDate': createDate.toIso8601String(),
      'imageUrl': imageUrl,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'isLiked': isLiked,
      'userName': userName,
      'avatarUrl': avatarUrl
    };
  }
}
