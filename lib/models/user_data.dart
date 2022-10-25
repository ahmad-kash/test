import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:password_manager/http_request.dart';
import 'package:password_manager/models/user.dart';

class UserData extends ChangeNotifier {
  static User user = User(email: '', name: '', token: '');

  static Future<bool> login(
      {required String email, required String password}) async {
    EasyLoading.show(status: 'login...');
    dynamic response = await HTTPRequest.post(
        url: 'login', body: User.userToJson(email: email, password: password));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      user = User.fromJson(response.body);
      print(user.token);
      EasyLoading.showSuccess('login successfully');
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(jsonDecode(response.body)['message']);
      return false;
    }
  }

  static Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    EasyLoading.show(status: 'signUp...');
    dynamic response = await HTTPRequest.post(
        url: 'signup',
        body: User.userToJson(email: email, password: password, name: name));
    if (response.statusCode == 200) {
      user = User.fromJson(response.body);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('signup successfully');
      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(jsonDecode(response.body)['message']);
      return false;
    }
  }

  static Future<bool> logout() async {
    EasyLoading.show(status: 'logout...');
    print(user.token);
    if (user.token == '') {
      EasyLoading.dismiss();
      return true;
    }
    dynamic response =
        await HTTPRequest.post(url: 'signout', token: user.token);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('logout successfully');
      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(jsonDecode(response.body)['message']);
      return false;
    }
  }
}
