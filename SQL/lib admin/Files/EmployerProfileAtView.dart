import 'package:admin/Classes/Admin.dart';
import 'package:admin/Classes/Employer.dart';
import 'package:admin/Classes/MySQL.dart';
import 'package:flutter/material.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../Classes/Employer.dart';
import '../CustomWidgets/TwoValuesText.dart';

class EmployerProfileAtView extends StatelessWidget {
  EmployerProfileAtView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map m = ModalRoute.of(context)?.settings.arguments as Map;
    Admin admin = m['admin'];

    Employer employer = m['employer'];
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/dummyPFP.png'),
                ),
              )),
          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(employer.userName, style: TextStyle(fontSize: 17.0)),
              )),
          Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 3.0,
          ),
          Key1("Name", 17.0),
          Value(employer.Name, 15.0),
          Key1("Date Of Birth", 17.0),
          Value(employer.DateOfBirth, 15.0),
          Key1("Contact Number", 17.0),
          Value(employer.ContactNumber, 15.0),
          Key1("Total Ads Posted", 17.0),
          Value(MySQL.query("", context), 15.0),
         ]),
      ),
    );
  }
}
