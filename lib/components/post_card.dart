import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/models/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onTap;

  const PostCard({super.key, required this.post, required this.onTap});

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
                  widget.post.avatarUrl != null
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.post.avatarUrl!),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/default_avatar.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.post.userName, style: kLableSize15Black),
                      Text(widget.post.timeAgo!, style: kLableSize13Grey),
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
                  Row(
                    children: [
                      SvgPicture.asset('assets/svgs/heart.svg'),
                      const SizedBox(width: 5),
                      Text(
                        widget.post.likeCount.toString(),
                        style: kLableSize13Black,
                      ),
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
                      SvgPicture.asset('assets/svgs/send.svg'),
                      const SizedBox(width: 5),
                      Text('1', style: kLableSize13Black),
                    ],
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
