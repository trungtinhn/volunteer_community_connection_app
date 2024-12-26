import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/models/nav.dart';
import 'package:volunteer_community_connection_app/screens/account/account_screen.dart';
import 'package:volunteer_community_connection_app/screens/bottom_nav/nav_bar.dart';
import 'package:volunteer_community_connection_app/screens/home/create_project_screen.dart';
import 'package:volunteer_community_connection_app/screens/home/home_screen.dart';
import 'package:volunteer_community_connection_app/screens/notification/notification_screen.dart';

import '../../controllers/user_controller.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final categoryKey = GlobalKey<NavigatorState>();
  final notificationKey = GlobalKey<NavigatorState>();
  final accountKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  final Usercontroller _usercontroller = Get.put(Usercontroller());

  @override
  void initState() {
    super.initState();

    items = [
      NavModel(
        page: const HomeScreen(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const HomeScreen(),
        navKey: categoryKey,
      ),
      NavModel(
        page: const NotificationScreen(),
        navKey: notificationKey,
      ),
      NavModel(
        page: AccountScreen(user: _usercontroller.getCurrentUser()!),
        navKey: accountKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateProjectScreen(),
              ),
            );
          },
          backgroundColor: AppColors.buleJeans, // Màu của nút nổi
          child: SvgPicture.asset(
            'assets/svgs/plus.svg',
          ),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}
