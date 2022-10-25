import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:password_manager/http_request.dart';
import 'package:password_manager/models/password.dart';
import 'package:password_manager/models/user_data.dart';

class PasswordData extends ChangeNotifier {
  List<Password> _passwords = [];

  UnmodifiableListView<Password> get passwords =>
      UnmodifiableListView(_passwords);

  addPassword(
      {required String email, required String password, String note = ''}) {
    //TODO send api call
    // _passwords.insert(0, Passowrd(id,))
  }
  deletePassword({required id}) async {
    EasyLoading.show(status: 'deleting...');
    try {
      dynamic response = await HTTPRequest.delete(
        url: "passwords/$id",
        token: UserData.user.token,
      );
      _passwords.removeWhere((item) => item.id == id);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('delete successfully');
      notifyListeners();
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('error can\'t delete password');
      return false;
    }
  }

  //password API
  Future<bool> createPassword(
      {required String email,
      required String password,
      String note = ''}) async {
    EasyLoading.show(status: 'uploading data....');
    try {
      dynamic response = await HTTPRequest.post(
        url: "passwords",
        token: UserData.user.token,
        body: jsonEncode({'email': email, 'password': password, 'note': note}),
        // Password.passwordToJson(email: email, password: password, note: note),
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('upload successfully');
        _passwords.insert(0, Password.fromJson(response.body));
        notifyListeners();
        return true;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(jsonDecode(response.body)['message']);
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('error can\t upload data');
      return false;
    }
  }

  getAllPasswords() async {
    if (_passwords.isNotEmpty) {
      return;
    }
    dynamic result = await HTTPRequest.get(
      url: 'passwords',
      token: UserData.user.token,
    );
    List data = jsonDecode(result.body)['data'];
    // print(data);
    for (var element in data) {
      _passwords.add(Password.fromDecodedJson(element));
    }
    // print(_passwords);
    notifyListeners();
  }

  void clearLocalPasswords() {
    _passwords = [];
    notifyListeners();
  }
}
