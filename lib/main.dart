import 'package:flutter/material.dart';
import 'package:password_manager/Pages/add_password_page.dart';
import 'package:password_manager/Pages/home_page.dart';
import 'package:password_manager/Pages/login_page.dart';
import 'package:password_manager/Pages/signUp_page.dart';
import 'package:password_manager/Pages/wlecome_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:password_manager/models/password_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PasswordData>(
      create: (_) => PasswordData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password manager',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const HomePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/addPassword': (context) => AddPasswordPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
