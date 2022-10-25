import 'package:flutter/material.dart';
import 'package:password_manager/components/button.dart';
import 'package:password_manager/components/custom_text_field.dart';
import 'package:password_manager/models/password_data.dart';
import 'package:password_manager/models/user_data.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  bool showSpinner = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/login.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            CustomTextField(
                icon: const Icon(Icons.email),
                hintText: 'enter your email',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                }),
            const SizedBox(
              height: 8.0,
            ),
            CustomTextField(
                icon: const Icon(Icons.lock),
                hintText: 'enter your password',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                }),
            const SizedBox(
              height: 24.0,
            ),
            Button(
              title: 'login',
              color: Colors.blueAccent,
              onPressed: () async {
                if (await UserData.login(email: email, password: password)) {
                  Provider.of<PasswordData>(context, listen: false)
                      .clearLocalPasswords();
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
