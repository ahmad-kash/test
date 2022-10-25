import 'package:flutter/material.dart';
import 'package:password_manager/components/button.dart';
import 'package:password_manager/components/custom_text_field.dart';
import 'package:password_manager/models/password_data.dart';
import 'package:provider/provider.dart';

class AddPasswordPage extends StatelessWidget {
  String email = "";
  String password = "";
  String note = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              CustomTextField(
                  icon: const Icon(Icons.note),
                  hintText: 'enter your note (optional)',
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (value) {
                    note = value;
                  }),
              const SizedBox(
                height: 24.0,
              ),
              Button(
                title: 'Add password',
                color: Colors.blueAccent,
                onPressed: () async {
                  if (await Provider.of<PasswordData>(context, listen: false)
                      .createPassword(
                          email: email, password: password, note: note)) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
