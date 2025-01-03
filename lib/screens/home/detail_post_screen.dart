import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/comment_controller.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/models/comment.dart';

import '../../controllers/like_controller.dart';
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
  final PostController _postController = Get.put(PostController());
  final LikeController _likeController = Get.put(LikeController());

  String? replyTo; // Tên người dùng đang được trả lời
  final TextEditingController commentController = TextEditingController();
  int? _selectReplyId;

  Post? _selectedPost;

  @override
  void initState() {
    super.initState();
    _fetchComments();
    _selectedPost = widget.post;
  }

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

    _selectedPost = await _postController.getPost(
        _selectedPost!.postId, _usercontroller.getCurrentUser()!.userId);

    setState(() {});

    await _postController.updateLoadedPosts(_selectedPost!);
  }

  Future<void> likePost(int postId) async {
    print(1);
    var result = await _likeController.likePost(
        _usercontroller.getCurrentUser()!.userId, postId);
    if (result) {
      var post = await _postController.getPost(
          postId, _usercontroller.getCurrentUser()!.userId);
      await _postController.updateLoadedPosts(post);

      _postController.updateLoadedPosts(post);
      _selectedPost = post;
      setState(() {});
    }
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
                          backgroundImage: _selectedPost!.avatarUrl != null
                              ? NetworkImage(widget.post.avatarUrl!)
                              : const AssetImage(
                                      'assets/images/default_avatar.jpg')
                                  as ImageProvider<Object>,
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          // Giới hạn chiều rộng của phần còn lại
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _selectedPost!.userName,
                                    style: kLableSize15Black,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    color: AppColors.buleJeans,
                                  ),
                                  Flexible(
                                    child: Text(
                                      _selectedPost!.communityName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: kLableSize15Bluew600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _selectedPost!.timeAgo!,
                                style: kLableSize13Grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      _selectedPost!.content,
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

                  _selectedPost!.imageUrl != null
                      ? Center(
                          child: Image.network(_selectedPost!.imageUrl!,
                              fit: BoxFit.cover))
                      : const SizedBox.shrink(),
                  // Like, Comment, Share
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              likePost(_selectedPost!.postId);
                              print(222);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _selectedPost!.isLiked
                                      ? SvgPicture.asset(
                                          'assets/svgs/heart_fill.svg')
                                      : SvgPicture.asset(
                                          'assets/svgs/heart.svg'),
                                  const SizedBox(width: 5),
                                  Text(_selectedPost!.likeCount.toString(),
                                      style: kLableSize13Black),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/svgs/comment.svg'),
                                const SizedBox(width: 5),
                                Text(_selectedPost!.commentCount.toString(),
                                    style: kLableSize13Black),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/svgs/send.svg'),
                                const SizedBox(width: 5),
                                Text('1', style: kLableSize13Black),
                              ],
                            ),
                          ),
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
                backgroundImage: comment.avatarUrl != null
                    ? NetworkImage(comment.avatarUrl!)
                    : const AssetImage('assets/images/default_avatar.jpg')
                        as ImageProvider<Object>,
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
