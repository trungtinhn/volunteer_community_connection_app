import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/components/button_green.dart';
import 'package:volunteer_community_connection_app/components/button_red.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class DonationCardWaitAccept extends StatelessWidget {
  final String status;
  final String title;
  final String type;
  final String description;
  final String startDate;
  final String endDate;
  final double progress;
  final int donationCount;
  final double currentAmount;
  final double goalAmount;
  final VoidCallback onAccept;
  final VoidCallback onDeny;
  final VoidCallback onDetails;
  final String imageUrl;
  final String role;

  const DonationCardWaitAccept({
    super.key,
    required this.status,
    required this.title,
    required this.type,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.donationCount,
    required this.currentAmount,
    required this.goalAmount,
    required this.onAccept,
    required this.onDeny,
    required this.onDetails,
    required this.imageUrl,
    required this.role,
  });

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'Sắp diễn ra':
        return Colors.yellow[100]!;
      case 'Đã duyệt':
        return Colors.green[100]!;
      default:
        return Colors.pink[100]!;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Sắp diễn ra':
        return Colors.yellow[800]!;
      case 'Đang diễn ra':
        return Colors.green[800]!;
      default:
        return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetails,
      child: Card(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator()), // Hiển thị trong khi tải
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Hiển thị khi có lỗi
              width: double.infinity,
              height: 250,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: _getStatusBackgroundColor(status),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: _getStatusTextColor(status),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '$startDate - $endDate',
                        style: kLableSize15Black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(title, style: kLableSize16Black),
                  const SizedBox(height: 4),

                  if (type == 'Quyên góp đồ vật')
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kLableSize15Black,
                    ),

                  if ({'Quyên góp tiền'}.contains(type))
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$donationCount lượt quyên góp',
                              style: kLableSize15Black,
                            ),
                            Text(
                              '${(progress * 100).toStringAsFixed(0)}%',
                              style: kLableSize15Black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                minHeight: 12,
                                borderRadius: BorderRadius.circular(8),
                                value: progress,
                                backgroundColor: Colors.grey[200],
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${currentAmount.toStringAsFixed(0)}đ',
                                style: kLableSize15Blue),
                            Text('/ ${goalAmount.toStringAsFixed(0)}đ',
                                style: kLableSize15Black),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (role == 'admin')
                        ButtonGreen(
                          des: 'Duyệt dự án',
                          onPress: onAccept,
                        ),
                      if ({'Đang chờ duyệt'}.contains(status))
                        ButtonRed(des: 'Từ chối dự án', onPress: onDeny),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
