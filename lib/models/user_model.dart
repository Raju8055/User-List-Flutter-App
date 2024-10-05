class UserModel {
  final String name;
  final String email;
  final String username;
  final String phone;

  UserModel({required this.name, required this.email, required this.username, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
    );
  }
}
