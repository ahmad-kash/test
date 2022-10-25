import 'package:flutter/material.dart';
import 'package:password_manager/Pages/add_password_page.dart';
import 'package:password_manager/Pages/show_password_page.dart';
import 'package:password_manager/models/password_data.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PasswordCard extends StatelessWidget {
  String email;
  String password;
  String note;
  int id;
  PasswordCard(
      {Key? key,
      required this.email,
      required this.id,
      this.password = "",
      this.note = ""})
      : super(key: key);

  void deletePassword(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "ALERT",
      desc: "Are you sure you want to delete password",
      buttons: [
        DialogButton(
          child: const Text(
            "delete",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Provider.of<PasswordData>(context, listen: false)
                .deletePassword(id: id);
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 0, 255, 149),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: ListTile(
          leading: const Icon(
            Icons.mail_outlined,
            color: Colors.white,
            size: 30.0,
          ),
          title: Text(
            email,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ShowPasswordPage(
                          email: email, password: password, note: note),
                    )));
          },
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              deletePassword(context);
            },
          ),
        ),
      ),
    );
  }
}
