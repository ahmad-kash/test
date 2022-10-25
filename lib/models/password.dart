import 'dart:convert';

class Password {
  int id;
  String email;
  String password;
  String note;
  Password(
      {required this.id,
      required this.email,
      required this.password,
      this.note = ""});
  factory Password.fromJson(dynamic body) {
    Map<String, dynamic> json = jsonDecode(body);
    print(json);
    return Password.fromDecodedJson(json);
  }
  factory Password.fromDecodedJson(dynamic json) {
    return Password(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      note: json['note'] ?? '',
    );
  }
  static String passwordToJson({required email, required password, note = ""}) {
    return jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'note': note,
    });
  }
}
