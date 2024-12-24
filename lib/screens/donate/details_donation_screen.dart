import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/post_controller.dart';
import 'package:volunteer_community_connection_app/screens/donate/donation_screen.dart';
import 'package:volunteer_community_connection_app/widgets/donor_tab.dart';
import 'package:volunteer_community_connection_app/widgets/post_tab.dart';

import '../../models/community.dart';

class DetailsDonationScreen extends StatefulWidget {
  const DetailsDonationScreen({super.key});

  @override
  State<DetailsDonationScreen> createState() => _DetailsDonationScreenState();
}

class _DetailsDonationScreenState extends State<DetailsDonationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<PostTabState> tab1Key = GlobalKey<PostTabState>();
  final GlobalKey<DonorTabState> tab2Key = GlobalKey<DonorTabState>();
  String imageUrl = 'assets/images/covid_relief.jpg';
  String title = 'Đồ dùng cho người khuỷu hoạch';
  int donationCount = 5;
  int currentAmount = 10000;
  int goalAmount = 20000;
  String status = 'Đang diễn ra';
  String description =
      'Bạn hẳn sẽ không cầm lòng nổi khi biết ở vùng cao, vùng sâu, vùng xa có hàng trăm, hàng ngàn đồng bào của chúng ta đang sống cuộc sống nghèo khó, thiếu thốn. Người già, trẻ em không có nổi tấm chăn, manh áo ấm; các gia đình lay lắt bên những mái nhà xuống cấp không đủ che gió, che mưa; biết bao em bé không có sách để đọc, không có quyển vở cây bút để viết, thậm chí có em không được đến trường. Với mong muốn những cảnh đời khó khăn sẽ được sưởi ấm bằng những món quà tuy nhỏ nhưng tràn đầy tình yêu thương, tràn đầy hơi ấm tình người, Trung tâm Tư vấn pháp luật phối hợp với BCH Công đoàn Học viện Tư pháp kêu gọi những tấm lòng nhân ái tham gia chương trình quyên góp, hỗ trợ, đóng góp về tinh thần và vật chất cho các chương trình từ thiện.';
  bool isExpanded = false;
  int _selectedTabIndex = 0;

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

    loadPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadPosts() async {
    _postController.loadedPosts.value =
        await _postController.getPostsByCommunity(communityId);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width - 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _getStatusBackgroundColor(status),
                      borderRadius: BorderRadius.circular(8),
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
                  Text(title, style: kLableSize20w700Black),
                  const SizedBox(height: 8),
                  Text(
                    'Thông tin cộng đồng',
                    style: kLableSize18Black,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$donationCount lượt quyên góp',
                          style: kLableSize15Black),
                      Text(
                          '${(currentAmount / goalAmount * 100).toStringAsFixed(0)}%',
                          style: kLableSize15Black),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(10),
                          value: (currentAmount / goalAmount),
                          backgroundColor: Colors.grey[200],
                          color: AppColors.buleJeans,
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
                      Text(
                        '/ ${goalAmount.toStringAsFixed(0)}đ',
                        style: kLableSize15Black,
                      ),
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
                        DonorTab(),
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
      ),
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
