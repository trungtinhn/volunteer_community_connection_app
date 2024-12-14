import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class DonationCard extends StatelessWidget {
  final String status;
  final String title;
  final double progress;
  final int donationCount;
  final double currentAmount;
  final double goalAmount;
  final VoidCallback onDonate;
  final VoidCallback onDetails;
  final String imageUrl;

  const DonationCard({
    super.key,
    required this.status,
    required this.title,
    required this.progress,
    required this.donationCount,
    required this.currentAmount,
    required this.goalAmount,
    required this.onDonate,
    required this.onDetails,
    required this.imageUrl,
  });

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'Sắp diễn ra':
        return Colors.yellow[100]!;
      case 'Đang diễn ra':
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
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),

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
                  const SizedBox(height: 16),

                  if ({'Đang diễn ra'}.contains(status))
                    ButtonBlue(des: 'Quyên góp ngay', onPress: onDonate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
