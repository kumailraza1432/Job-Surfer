import 'package:Employer/CustomWidgets/NotificationView.dart';

import '../Classes/Notifications.dart';
import '../CustomWidgets/JS_AppBar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(child:Column(children: Notifications.NotificationsList.map((e) => NotificationView(e)).toList())),
    );
  }
}
