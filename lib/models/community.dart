class Community {
  final int communityId;
  final String communityName;
  final String description;
  final PublishStatus
      publishStatus; // Thay đổi từ isPublished thành publishStatus
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
    required this.publishStatus,
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
      publishStatus: PublishStatus
          .values[json['publishStatus'] as int], // Map giá trị int thành enum
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
      latitude: json['latitude'],
    );
  }

  // Hàm kiểm tra trạng thái của dự án
  String checkStatus() {
    final now = DateTime.now();

    if (publishStatus == PublishStatus.Pending) {
      return 'Đang chờ duyệt';
    }

    if (publishStatus == PublishStatus.Rejected) {
      return 'Đã bị từ chối';
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

// Enum PublishStatus
enum PublishStatus {
  // ignore: constant_identifier_names
  Pending, // Chờ duyệt
  // ignore: constant_identifier_names
  Approved, // Đã duyệt
  // ignore: constant_identifier_names
  Rejected // Đã bị từ chối
}
