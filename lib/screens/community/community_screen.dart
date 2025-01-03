import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/screens/chat/chat_screen.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/widgets/admin_community/community_rejected.dart';
import 'package:volunteer_community_connection_app/widgets/admin_community/community_wait_accept.dart';
import 'package:volunteer_community_connection_app/widgets/common_community/my_community_tab.dart';
import 'package:volunteer_community_connection_app/widgets/user_community/my_community_rejected.dart';
import 'package:volunteer_community_connection_app/widgets/user_community/my_community_wait_accept.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  Usercontroller userController = Get.put(Usercontroller());

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
                  buildTab(0, 'Dự án', 2),
                  buildTab(1, 'Chờ duyệt', 2),
                  buildTab(2, 'Bị từ chối', 2),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          const MyCommunityTab(),
          userController.currentUser.value!.role == 'admin'
              ? const CommunityWaitAccept()
              : const MyCommunityWaitAcceptTab(),
          userController.currentUser.value!.role == 'admin'
              ? const CommunityRejected()
              : const MyCommunityRejectedTab(),
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
        width: (type == 1 ? 103 : 150),
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
