class Community {
  final int communityId;
  final String communityName;
  final String description;
  final bool isPublished;
  final int adminId;
  final DateTime createDate;
  final DateTime startDate;
  final DateTime endDate;
  final double targetAmount;
  final String imageUrl;
  final double currentAmount;
  final int donationCount;

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
      targetAmount: json['targetAmount'] as double,
      imageUrl: json['imageUrl'] as String,
      currentAmount: json['currentAmount'] as double,
      donationCount: json['donationCount'] as int,
    );
  }
}
