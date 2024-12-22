class User {
  final int userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String avatarUrl;
  final String role;
  final DateTime dayOfBirth;
  final String? token;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.avatarUrl,
      required this.role,
      required this.dayOfBirth,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      role: json['role'] ?? '',
      token: json['token'] ?? '',
      dayOfBirth: DateTime.parse(json['dayOfBirth'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'role': role,
      'token': token,
      'dayOfBirth': dayOfBirth.toIso8601String(),
    };
  }
}
