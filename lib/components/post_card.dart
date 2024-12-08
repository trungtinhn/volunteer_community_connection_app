import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String description;
  final String imageUrl;
  final int likes;
  final int comments;
  final int shares;
  final VoidCallback onTap;

  const PostCard(
      {super.key,
      required this.username,
      required this.timeAgo,
      required this.description,
      required this.imageUrl,
      required this.likes,
      required this.comments,
      required this.shares,
      required this.onTap});

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
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.imageUrl),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.username, style: kLableSize15Black),
                      Text(widget.timeAgo, style: kLableSize13Grey),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.description,
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
            Image.asset(widget.imageUrl, fit: BoxFit.cover),
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
                        widget.likes.toString(),
                        style: kLableSize13Black,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svgs/comment.svg'),
                      const SizedBox(width: 5),
                      Text(widget.comments.toString(),
                          style: kLableSize13Black),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svgs/send.svg'),
                      const SizedBox(width: 5),
                      Text(widget.shares.toString(), style: kLableSize13Black),
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
