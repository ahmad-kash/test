import 'package:flutter/material.dart';
import 'package:password_manager/components/button.dart';
import 'package:password_manager/components/custom_text_field.dart';
import 'package:password_manager/models/password_data.dart';
import 'package:provider/provider.dart';

class ShowPasswordPage extends StatelessWidget {
  final String email;
  final String password;
  final String note;
  const ShowPasswordPage(
      {Key? key, required this.email, required this.password, this.note = ""})
      : super(key: key);

  Widget card(value, Icon icon) {
    return Card(
      color: const Color.fromARGB(255, 0, 255, 149),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: ListTile(
          leading: icon,
          title: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            card(
              email,
              const Icon(
                Icons.mail_outlined,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            card(
              password,
              const Icon(
                Icons.lock,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            card(
              note,
              const Icon(
                Icons.note,
                color: Colors.white,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
