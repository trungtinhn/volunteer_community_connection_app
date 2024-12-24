import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/comment_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/models/comment.dart';

import '../../models/post.dart';

class DetailPostScreen extends StatefulWidget {
  final Post post;
  const DetailPostScreen({super.key, required this.post});

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  bool isExpanded = false;

  final CommentController _commentController = Get.put(CommentController());
  final Usercontroller _usercontroller = Get.put(Usercontroller());

  String? replyTo; // Tên người dùng đang được trả lời
  final TextEditingController commentController = TextEditingController();
  int? _selectReplyId;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  final Map<String, dynamic> postData = {
    "username": "Nguyễn Văn A",
    "timeAgo": "2 giờ trước",
    "description":
        "Hôm nay là một ngày ý nghĩa khi chúng tôi cùng nhau thực hiện dự án thiện nguyện. Cùng chung tay để mang lại những giá trị tích cực nhé!",
    "imageUrl": "https://i.pravatar.cc/300",
    "likes": 120,
    "comments": 15,
    "shares": 5,
  };

  final List<Map<String, dynamic>> commentsData = [
    {
      "username": "Người dùng 1",
      "avatarUrl": "https://i.pravatar.cc/150?img=1",
      "comment": "Bài viết rất hay và ý nghĩa!",
      "timeAgo": "2 giờ trước",
      "children": [
        {
          "username": "Người dùng 2",
          "avatarUrl": "https://i.pravatar.cc/150?img=2",
          "comment": "Đồng ý, rất ý nghĩa!",
          "timeAgo": "1 giờ trước",
        },
        {
          "username": "Người dùng 3",
          "avatarUrl": "https://i.pravatar.cc/150?img=3",
          "comment": "Mọi người cùng chung tay nhé!",
          "timeAgo": "30 phút trước",
        },
      ]
    },
    {
      "username": "Người dùng 4",
      "avatarUrl": "https://i.pravatar.cc/150?img=4",
      "comment": "Mình đã chia sẻ bài viết này!",
      "timeAgo": "1 ngày trước",
      "children": [],
    },
  ];

  Future<void> _fetchComments() async {
    _commentController.loadedComment.value =
        await _commentController.getCommentsByPost(widget.post.postId);
  }

  Future<void> _createComment() async {
    final Map<String, dynamic> commentData = {
      'content': commentController.text,
      'postId': widget.post.postId,
      'userId': _usercontroller.getCurrentUser()!.userId,
      'createDate': DateTime.now().toIso8601String(),
      'parentCommentId': _selectReplyId
    };
    await _commentController.createComment(commentData);
    commentController.clear();
    _selectReplyId = null;
    _fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết bài đăng',
          style: kLableSize20w700Black,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: widget.post.avatarUrl != null
                              ? NetworkImage(widget.post.avatarUrl!)
                              : const AssetImage(
                                      'assets/images/default_avatar.jpg')
                                  as ImageProvider<Object>,
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.post.userName,
                                style: kLableSize15Black),
                            Text(widget.post.timeAgo!, style: kLableSize13Grey),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: AppColors.blue,
                            ),
                            Text('Hỗ trợ bão cho đồng bào',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: kLableSize15Bluew600),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.post.content,
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                  ),
                  if (!isExpanded)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          'Xem thêm',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  if (isExpanded)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          'Thu gọn',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  // Ảnh bài viết

                  widget.post.imageUrl != null
                      ? Center(
                          child: Image.network(widget.post.imageUrl!,
                              fit: BoxFit.cover))
                      : const SizedBox.shrink(),
                  // Like, Comment, Share
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child:
                                    SvgPicture.asset('assets/svgs/heart.svg')),
                            const SizedBox(width: 5),
                            Text(widget.post.likeCount.toString(),
                                style: kLableSize13Black),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/svgs/comment.svg'),
                            const SizedBox(width: 5),
                            Text(widget.post.commentCount.toString(),
                                style: kLableSize13Black),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child:
                                    SvgPicture.asset('assets/svgs/send.svg')),
                            const SizedBox(width: 5),
                            Text('1', style: kLableSize13Black),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Danh sách bình luận
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: _commentController.loadedComment
                            .where((comment) => comment.parentCommentId == null)
                            .map((comment) => _buildComment(comment))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  // Hàm xây dựng một bình luận
  Widget _buildComment(Comment comment) {
    List<Comment> replies = _commentController.loadedComment
        .where((reply) => reply.parentCommentId == comment.commentId)
        .toList(); // Lỗi>

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bình luận cha
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: comment.avatarUrl == null
                    ? const AssetImage('assets/images/default_avatar.jpg')
                        as ImageProvider
                    : NetworkImage(comment.avatarUrl!),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(comment.content),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Hiển thị thời gian
                Text(
                  comment.timeAgo ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 30),

                comment.parentCommentId == null
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectReplyId == comment.commentId) {
                              _selectReplyId = null;
                            } else {
                              _selectReplyId = comment.commentId;
                            }
                          });

                          debugPrint(
                              "Phản hồi bình luận của ${comment.userName}");
                        },
                        child: Text("Phản hồi",
                            style: _selectReplyId == comment.commentId
                                ? kLableSize13Blue
                                : kLableSize13Grey),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            color: AppColors.greyIron,
          ),
          // Bình luận con
          if (replies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 5),
              child: Column(
                children:
                    (replies).map((child) => _buildComment(child)).toList(),
              ),
            ),
        ],
      ),
    );
  }

  // Thanh nhập bình luận
  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (replyTo != null)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Row(
                children: [
                  Text('Trả lời $replyTo', style: kLableSize13Grey),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        replyTo = null;
                      });
                    },
                    child:
                        const Icon(Icons.close, size: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              _usercontroller.getCurrentUser()!.avatarUrl == null
                  ? Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/default_avatar.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              _usercontroller.getCurrentUser()!.avatarUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: commentController,
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                      hintText: 'Nhập bình luận...',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyIron),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.greyShuttle),
                      ),
                      labelStyle: const TextStyle(
                          fontFamily: 'CeraPro', fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: AppColors.white),
                  style: kLableSize15Black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () {
                  _createComment();
                  debugPrint(
                      'Đã gửi bình luận: ${commentController.text} - Trả lời: $replyTo');
                  setState(() {
                    commentController.clear();
                    replyTo = null;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
