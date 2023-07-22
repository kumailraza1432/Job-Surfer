

import 'package:applicant/Classes/Applicant.dart';

import '../Classes/Notifications.dart';
import 'package:flutter/material.dart';
import '../Classes/MySQL.dart';
import '../Variables.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/txtfeilds.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> login(userName,password,context) async {
    Navigator.pushNamed(context, "/Spinner");
    if (!MySQL.Connected)
      await MySQL.getConnection(context);

    if (UserName.text.length<1|| UserName.text.contains(" ")|| Password.text.length<1 || !(await applicant.login(userName, password, context))) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Login Failed"),
            content: Text("Invalid username, or password"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Okay"))
            ],
          ));
    } else {
      Navigator.pop(context);
      Notifications.GeneratedForCNIC=applicant.CNIC;
      Navigator.pushReplacementNamed(context, "/ApplicantLoggedInScreen", arguments: {"applicant":applicant});}
  }
  Applicant applicant = Applicant();
  TextEditingController UserName = TextEditingController();
  TextEditingController Password = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: JS_AppBar


          (),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Container(
                        child: Image(
                          image: AssetImage('assets/images/logo.png'),
                          height: 270,
                          width: 270,
                        ),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0))),
                Container(
                  child: Text("User Name *"),
                  padding: EdgeInsets.fromLTRB(
                    20.0,
                    0.0,
                    260.0,
                    0.0,
                  ),
                ),
                Container(
                    child: JsTextFeildIconed(
                        "For example, User_name123",
                        UserName,
                        Icon(Icons.person),
                        20.0,
                        10.0,
                        10.0,
                        0.0,
                        "Spaces are not allowed")),
                Container(
                  child: Text("Password *"),
                  padding: EdgeInsets.fromLTRB(
                    20.0,
                    20.0,
                    260.0,
                    0.0,
                  ),
                ),
                Container(
                    child: JsTextFeildIconed("Password", Password, Icon(Icons.lock),
                        20.0, 10.0, 10.0, 0.0, "", true)),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(130,00,70,0),
                    child: FlatButton(
                        color: colorThird_G,
                        onPressed: ()async { await login(UserName.text,Password.text,context); },
                        child: Text("Login")),
                  ),
                ])
              ],
            )));
  }
}
