import 'package:admin/Classes/Admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Classes/Admin.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';


class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late Admin admin;

  @override
  Widget build(BuildContext context) {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map<String, Admin>;
    admin = m1["admin"];
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/itachi.jpg"))),
            Center(
                child: Text(admin.UserName, style: TextStyle(fontSize: 25))),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  thickness: 3.0,
                )),
            Key1("Name", 20.0),
            Value(admin.Name, 20.0),
            Key1("Username", 20.0),
            Value(admin.UserName, 20.0),
            Key1("CNIC", 20.0),
            Value(admin.CNIC, 20.0),
            Key1("Date of Birth", 20.0),
            Value(admin.DOB, 20.0),
            Key1("Contact Number", 20.0),
            Value(admin.ContactNumber, 20.0),
          ],
        ),
      ),
    );
  }
}
