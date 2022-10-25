import 'dart:convert';
import 'package:password_manager/models/user_data.dart';

class User {
  String name;
  String email;
  String token;
  User({
    required this.name,
    required this.email,
    required this.token,
  });
  factory User.fromJson(dynamic body) {
    Map<String, dynamic> json = jsonDecode(body);
    return User(
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
  static String userToJson(
      {required String email, required String password, String name = ''}) {
    Map<String, String> userObj = {'email': email, 'password': password};
    if (name != '') {
      userObj['name'] = name;
    }
    return jsonEncode(userObj);
  }
}
