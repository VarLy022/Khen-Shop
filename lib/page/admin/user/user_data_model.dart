// data model for a user
class User {
  final int? userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? role;
  final String? user_image;

  User({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.role,
    this.user_image,
  });

  // create user object from json data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // ถ้า name == null ก็ตั้งเป็น '' (ว่าง ๆ) แทน
      // userId: json['user_id'] ?? '',
      // name: json['name'] ?? '',
      // email: json['email'] ?? '',
      // password: json['password'] ?? '',
      // phone: json['phone'] ?? '',
      // role: json['role'] ?? '',
      // user_image: json['user_image'] ?? '',
      // createdAt: json['created_at'],

      // userId: json['user_id'],
      // name: json['name'],
      // email: json['email'],
      // password: json['password'],
      // phone: json['phone'],
      // role: json['role'],
      // user_image: json['user_image'],

      userId: json['user_id'] as int?,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'],
      user_image: json['user_image'],
    );
  }

  // method the convert user to object json for send to server
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'user_image': user_image,
    };
  }
}
