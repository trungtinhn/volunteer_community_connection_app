import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;
  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          color: Colors.white,
          child: Row(
            children: [
              navItem(
                pageIndex == 0
                    ? 'assets/svgs/home_fill.svg'
                    : 'assets/svgs/home.svg',
                pageIndex == 0,
                onTap: () => onTap(0),
              ),
              navItem(
                pageIndex == 1
                    ? 'assets/svgs/category_fill.svg'
                    : 'assets/svgs/category.svg',
                pageIndex == 1,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 40),
              navItem(
                pageIndex == 2
                    ? 'assets/svgs/notification_fill.svg'
                    : 'assets/svgs/notification.svg',
                pageIndex == 2,
                onTap: () => onTap(2),
              ),
              navItem(
                pageIndex == 3
                    ? 'assets/svgs/profile_fill.svg'
                    : 'assets/svgs/profile.svg',
                pageIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget navItem(String icon, bool selected, {Function()? onTap}) {
  return Expanded(
    child: InkWell(
        onTap: onTap,
        child: Center(
          child: SvgPicture.asset(
            icon,
            colorFilter: !selected
                ? const ColorFilter.mode(AppColors.buleJeans, BlendMode.srcIn)
                : null,
          ),
        )),
  );
}
