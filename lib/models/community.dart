class Community {
  final int communityId;
  final String communityName;
  final String description;
  final bool isPublished;
  final int adminId;
  final DateTime createDate;
  final DateTime startDate;
  final DateTime endDate;
  final double? targetAmount;
  final String imageUrl;
  final double currentAmount;
  final int donationCount;
  final String type;
  final double? longtitude;
  final double? latitude;

  Community({
    required this.communityId,
    required this.communityName,
    required this.description,
    required this.isPublished,
    required this.adminId,
    required this.createDate,
    required this.startDate,
    required this.endDate,
    required this.targetAmount,
    required this.imageUrl,
    required this.currentAmount,
    required this.donationCount,
    required this.type,
    required this.longtitude,
    required this.latitude,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
        communityId: json['communityId'] as int,
        communityName: json['communityName'] as String,
        description: json['description'] as String,
        isPublished: json['isPublished'] as bool,
        adminId: json['adminId'] as int,
        createDate: DateTime.parse(json['createDate'] as String),
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        targetAmount: json['targetAmount'],
        imageUrl: json['imageUrl'] as String,
        currentAmount: (json['currentAmount'] is int)
            ? (json['currentAmount'] as int).toDouble()
            : json['currentAmount'],
        donationCount: json['donationCount'] as int,
        type: json['type'] as String,
        longtitude: json['longitude'],
        latitude: json['latitude']);
  }

  // Hàm kiểm tra trạng thái của dự ánn
  String checkStatus() {
    final now = DateTime.now();

    if (!isPublished) {
      return 'Đang chờ duyệt';
    }

    if (now.isBefore(startDate)) {
      return 'Sắp diễn ra';
    } else if (now.isAfter(startDate) && now.isBefore(endDate)) {
      if (targetAmount != null && currentAmount >= targetAmount!) {
        return 'Hoàn thành mục tiêu';
      }
      return 'Đang diễn ra';
    } else if (now.isAfter(endDate)) {
      if (targetAmount != null && currentAmount >= targetAmount!) {
        return 'Kết thúc thành công';
      }
      return 'Kết thúc nhưng không đạt mục tiêu';
    }
    return 'Trạng thái không xác định';
  }
}
