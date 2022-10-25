import 'package:flutter/material.dart';
import 'package:password_manager/components/password_card.dart';
import 'package:password_manager/models/password_data.dart';
import 'package:password_manager/models/user.dart';
import 'package:password_manager/models/user_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getPasswords() async {
    await PasswordData().getAllPasswords();
  }

  List<Widget> passwordsCard(passwords) {
    List<Widget> passwordsCard = [];
    for (var element in passwords) {
      passwordsCard.add(PasswordCard(
        email: element.email,
        password: element.password,
        note: element.note,
        id: element.id,
      ));
    }
    return passwordsCard;
  }

  Widget mainView(provider) {
    if (provider.passwords.isNotEmpty) {
      return ListView(
        // reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: passwordsCard(provider.passwords),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'you have not upload any password yet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PasswordData>(context, listen: false).getAllPasswords();
    return Scaffold(
      drawer: null,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                if (await UserData.logout()) {
                  Navigator.pop(context);
                }
              },
              child: const Text('logout'),
            ),
          ),
        ],
        title: const Text('Password Manager'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Consumer<PasswordData>(
          builder: (context, provider, child) {
            return mainView(provider);
          },
        ),
      ),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            foregroundColor: Color.fromARGB(255, 187, 255, 0),
            onPressed: () {
              Navigator.pushNamed(context, '/addPassword');
            },
            child: const Icon(
              Icons.add,
              size: 50.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
