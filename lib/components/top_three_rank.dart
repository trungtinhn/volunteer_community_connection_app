import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/models/donation.dart';

class Top3Component extends StatelessWidget {
  final List<Donation> top3;

  const Top3Component({super.key, required this.top3});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTopPosition(
          rank: 2,
          entry: top3.length > 1 ? top3[1] : null,
          height: 140,
          backgroundColor: Colors.purple[200],
        ),
        _buildTopPosition(
          rank: 1,
          entry: top3.isNotEmpty ? top3[0] : null,
          height: 180,
          backgroundColor: Colors.purple[400],
        ),
        _buildTopPosition(
          rank: 3,
          entry: top3.length > 2 ? top3[2] : null,
          height: 100,
          backgroundColor: Colors.purple[300],
        ),
      ],
    );
  }

  Widget _buildTopPosition({
    required int rank,
    required Donation? entry,
    required double height,
    required Color? backgroundColor,
  }) {
    final numberFormat = NumberFormat('#,###');

    int amountInt = entry != null ? entry.amount.toInt() : 0;
    String formattedAmount = numberFormat.format(amountInt);
    return SizedBox(
      height: 330,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (entry != null)
            Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue[100],
                  backgroundImage: entry.avatarUrl != null
                      ? NetworkImage(entry.avatarUrl!)
                      : const AssetImage('assets/images/default_avatar.jpg')
                          as ImageProvider<Object>,
                ),
                const SizedBox(height: 12),
                // Name
                Text(
                  entry.userName,
                  style: kLableSize15Black,
                  maxLines: 1,
                ),
                // Amount
                Container(
                  width: 90,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$formattedAmountđ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kLableSize15White,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),

          // Rank Display
          Container(
            width: 110,
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xFF9087E5),
                      Color(0xFFCDC9F3),
                    ],
                    tileMode: TileMode.clamp)),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
