import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/components/map_view.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/community_controller.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/helpers/util.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/screens/donate/donation_screen.dart';
import 'package:volunteer_community_connection_app/widgets/donor_tab.dart';
import 'package:volunteer_community_connection_app/widgets/post_tab.dart';

import '../../models/community.dart';

class DetailsDonationScreen extends StatefulWidget {
  final int communityId;
  const DetailsDonationScreen({super.key, required this.communityId});

  @override
  State<DetailsDonationScreen> createState() => _DetailsDonationScreenState();
}

class _DetailsDonationScreenState extends State<DetailsDonationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<PostTabState> tab1Key = GlobalKey<PostTabState>();
  final GlobalKey<DonorTabState> tab2Key = GlobalKey<DonorTabState>();

  bool isExpanded = false;
  int _selectedTabIndex = 0;

  final CommunityController _communityController =
      Get.put(CommunityController());
  int communityId = 1;

  Community community = Community(
      communityId: 1,
      communityName: 'Community 1',
      description: 'Description 1',
      imageUrl: 'assets/images/covid_relief.jpg',
      isPublished: true,
      targetAmount: 20000,
      currentAmount: 10000,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      type: 'Quyên góp đồ vật',
      createDate: DateTime.now(),
      adminId: 1,
      donationCount: 5,
      longtitude: 0.0,
      latitude: 0.0);

  final PostController _postController = Get.put(PostController());
  final Usercontroller _usercontroller = Get.put(Usercontroller());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index != _selectedTabIndex) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
    loadCommunity(widget.communityId);

    loadPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadCommunity(int communityId) async {
    await _communityController.getCommunityById(communityId);
  }

  Future<void> loadPosts() async {
    _postController.loadedPosts.value =
        await _postController.getPostsByCommunity(
            communityId, _usercontroller.getCurrentUser()!.userId);
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Chi tiết dự án',
          style: kLableSize20w700Black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/svgs/upload.svg'),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (_communityController.community.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        var community = _communityController.community.value!;
        double progress = 0.0;
        String status = community.checkStatus();
        if (community.targetAmount != null) {
          progress = community.currentAmount / community.targetAmount!;
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              CachedNetworkImage(
                imageUrl: community.imageUrl,
                placeholder: (context, url) => const Center(
                    child:
                        CircularProgressIndicator()), // Hiển thị trong khi tải
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error), // Hiển thị khi có lỗi
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: _getStatusBackgroundColor(status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        community.checkStatus(),
                        style: TextStyle(
                          color: _getStatusTextColor(status),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(community.communityName, style: kLableSize20w700Black),
                    const SizedBox(height: 8),
                    Text(
                      'Thời gian: ${formatDate(community.startDate)} - ${formatDate(community.endDate)}',
                      style: kLableSize15Black,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      community.description,
                      maxLines: isExpanded ? null : 3,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: kLableSize15Grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'Thu gọn' : 'Xem thêm',
                        style: const TextStyle(
                          color: AppColors.buleJeans,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if ({'Quyên góp tiền'}.contains(community.type))
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${community.donationCount} lượt quyên góp',
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
                              Text(
                                  '${community.currentAmount.toStringAsFixed(0)}đ',
                                  style: kLableSize15Blue),
                              Text(
                                  '/ ${community.targetAmount!.toStringAsFixed(0)}đ',
                                  style: kLableSize15Black),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    if ({'Quyên góp đồ vật'}.contains(community.type))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Địa chỉ quyên góp: ', style: kLableSize15Black),
                          const SizedBox(height: 8),
                          MapView(
                              position: LatLng(
                                  community.latitude!, community.longtitude!)),
                        ],
                      ),
                    const SizedBox(height: 8),
                    if ({'Đang diễn ra'}.contains(status))
                      ButtonBlue(
                          des: 'Quyên góp ngay',
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DonationScreen(),
                              ),
                            );
                          }),
                  ],
                ),
              ),
              Container(
                height: double.maxFinite,
                color: AppColors.whitePorcelain,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment(0.8, 1),
                              colors: <Color>[
                                AppColors.darkBlue,
                                AppColors.buleJeans
                              ],
                              tileMode: TileMode.mirror,
                            ),
                          ),
                          labelStyle: kLableSize15Blue,
                          dividerColor: Colors.white,
                          tabs: [
                            buildTab(0, 'Bài đăng', 1),
                            buildTab(1, 'Nhà hảo tâm', 2),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          PostTab(
                            community: community,
                          ),
                          DonorTab(
                            community: community,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
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
