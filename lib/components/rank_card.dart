import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class RankCard extends StatelessWidget {
  final int rank;
  final String avatar;
  final String name;
  final String amount;
  final bool isEven;

  const RankCard({
    super.key,
    required this.rank,
    required this.avatar,
    required this.name,
    required this.amount,
    required this.isEven,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isEven ? AppColors.lightBlue : AppColors.lightPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$rank',
            style: kLableSize15Black,
          ),
          const SizedBox(width: 15),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: AssetImage(avatar), fit: BoxFit.cover)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              name,
              style: kLableSize15Black,
            ),
          ),
          Text(
            amount,
            style: kLableSize15Black,
          ),
        ],
      ),
    );
  }
}
