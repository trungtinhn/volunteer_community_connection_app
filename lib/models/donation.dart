class Donation {
  final int donationId;
  final double amount;
  final int userId;
  final DateTime donateDate;
  final String? avatarUrl;
  final String userName;

  Donation(
      {required this.donationId,
      required this.amount,
      required this.userId,
      required this.donateDate,
      required this.avatarUrl,
      required this.userName});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      donationId: json['donationId'],
      amount: json['amount'],
      userId: json['userId'],
      donateDate: DateTime.parse(json['donateDate']),
      avatarUrl: json['avatarUrl'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'donationId': donationId,
        'amount': amount,
        'userId': userId,
        'donateDate': donateDate.toIso8601String(),
        'avatarUrl': avatarUrl,
        'userName': userName,
      };
}
