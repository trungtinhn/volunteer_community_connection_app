import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/auth_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/screens/account/login_screen.dart';
import 'package:volunteer_community_connection_app/screens/chat/chat_screen.dart';
import 'package:volunteer_community_connection_app/widgets/common_community/coming_soon_tab.dart';
import 'package:volunteer_community_connection_app/widgets/common_community/end_tab.dart';
import 'package:volunteer_community_connection_app/widgets/common_community/going_on_tab.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ComingSoonTabState> tab1Key = GlobalKey<ComingSoonTabState>();
  final GlobalKey<GoingOnTabState> tab2Key = GlobalKey<GoingOnTabState>();
  final GlobalKey<EndTabState> tab3Key = GlobalKey<EndTabState>();
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final Authcontroller _authcontroller = Get.put(Authcontroller());
  final Usercontroller _usercontroller = Get.put(Usercontroller());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _logOut() async {
    await _authcontroller.logout();
    _usercontroller.removeCurrentUser();

    Get.off(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whisper,
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/svgs/search.svg'),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontFamily: 'CeraPro',
                        color: AppColors.greyIron,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF1F8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                      icon: SvgPicture.asset('assets/svgs/send.svg'),
                      onPressed: () {
                        Get.to(() => const ChatScreen());
                      }),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF1F8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                      icon: SvgPicture.asset('assets/svgs/send.svg'),
                      onPressed: () {
                        _logOut();
                      }),
                ),
              ],
            ),
            const SizedBox(width: 16),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[AppColors.darkBlue, AppColors.buleJeans],
                    tileMode: TileMode.mirror,
                  ),
                ),
                labelColor: AppColors.greyShuttle,
                unselectedLabelColor: AppColors.greyShuttle,
                labelStyle: kLableSize15BlueDark,
                dividerColor: Colors.white,
                tabs: [
                  buildTab(0, 'Sắp diễn ra', 1),
                  buildTab(1, 'Đang diễn ra', 2),
                  buildTab(2, 'Đã kết thúc', 1),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          ComingSoonTab(
            key: tab1Key,
          ),
          GoingOnTab(
            key: tab2Key,
          ),
          EndTab(
            key: tab3Key,
          )
        ]));
  }

  Widget buildTab(int index, String text, int type) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
        _tabController.animateTo(index);
      },
      child: SizedBox(
        height: 36,
        width: (type == 1 ? 103 : 120),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: _selectedTabIndex == index
                  ? Colors.white
                  : AppColors.buleJeans,
            ),
          ),
        ),
      ),
    );
  }
}
