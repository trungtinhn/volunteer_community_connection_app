import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/models/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final bool showCommunity;
  final VoidCallback onTap;
  final VoidCallback onTapLike;
  final VoidCallback onTapViewAccount;

  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.showCommunity,
    required this.onTapLike,
    required this.onTapViewAccount,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                    onTap: widget.onTapViewAccount,
                    child: CircleAvatar(
                      backgroundImage: widget.post.avatarUrl != null
                          ? NetworkImage(widget.post.avatarUrl!)
                          : const AssetImage('assets/images/default_avatar.jpg')
                              as ImageProvider<Object>,
                      radius: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    // Giới hạn chiều rộng của Column
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: widget.onTapViewAccount,

                              child: Text(
                                widget.post.userName,
                                style: kLableSize15Black,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.showCommunity) ...[
                              const Icon(
                                Icons.arrow_right,
                                color: AppColors.buleJeans,
                              ),
                              Flexible(
                                child: Text(
                                  widget.post.communityName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kLableSize15Bluew600,
                                ),
                              ),
                            ],
                          ],
                        ),
                   if (!widget.showCommunity)
                        Text(
                            widget.post.type == 1
                                ? 'Quản trị viên'
                                : widget.post.type == 2
                                    ? 'Chủ dự án'
                                    : widget.post.type == 3
                                        ? 'Người đóng góp'
                                        : '',
                            style: kLableSize13Grey),
                        Text(
                          widget.post.timeAgo ?? '',
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
                widget.post.content,
                maxLines: isExpanded ? null : 2,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
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
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Xem thêm',
                    style: TextStyle(
                        color: AppColors.buleJeans,
                        fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Thu gọn',
                    style: TextStyle(
                        color: AppColors.buleJeans,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            widget.post.imageUrl != null
                ? Container(
                    height: 200,
                    width: double.infinity,
                    child:
                        Image.network(widget.post.imageUrl!, fit: BoxFit.cover),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: widget.onTapLike,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.post.isLiked
                                ? SvgPicture.asset('assets/svgs/heart_fill.svg')
                                : SvgPicture.asset('assets/svgs/heart.svg'),
                            const SizedBox(width: 5),
                            Text(
                              widget.post.likeCount.toString(),
                              style: kLableSize13Black,
                            ),
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
                          Text(widget.post.commentCount.toString(),
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
          ],
        ),
      ),
    );
  }
}
