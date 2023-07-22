import 'package:Employer/CustomWidgets/CnicWidget.dart';
import 'package:Employer/CustomWidgets/JS_AppBar.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: JS_AppBar(),
    body:    CNICWidget(),
    );
  }
}
