import 'package:http/http.dart' as http;
import 'package:password_manager/global_const.dart';

class HTTPRequest {
  static get({String url = '', String token = ''}) {
    try {
      return http.get(
        Uri.parse("$appURL/$url"),
        headers: getHeaders(token: token),
      );
    } catch (e) {
      print(e);
    }
  }

  static post({String url = '', String token = '', dynamic body}) {
    try {
      return http.post(
        Uri.parse("$appURL/$url"),
        headers: getHeaders(token: token),
        body: body,
      );
    } catch (e) {
      print(e);
    }
  }

  static delete({String url = '', String token = '', dynamic body}) {
    try {
      return http.post(
        Uri.parse("$appURL/$url"),
        headers: getHeaders(token: token),
      );
    } catch (e) {
      print(e);
    }
  }

  static Map<String, String> getHeaders({required token}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != '') {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
