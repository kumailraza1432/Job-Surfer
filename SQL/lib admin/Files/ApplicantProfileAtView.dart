import 'package:flutter/material.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../Classes/Applicant.dart';
import '../CustomWidgets/TwoValuesText.dart';

class ApplicantProfileAtView extends StatelessWidget {
  const ApplicantProfileAtView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map m = ModalRoute.of(context)?.settings.arguments as Map;
    Applicant applicant = m['applicant'];
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
            child: Text(applicant.userName, style: TextStyle(fontSize: 17.0)),
          )),
          Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 3.0,
          ),
          Key1("UserName", 17.0),
          Value(applicant.Name, 15.0),
          Key1("Date Of Birth", 17.0),
          Value(applicant.DateOfBirth, 15.0),
          Key1("Contact Number", 17.0),
          Value(applicant.ContactNumber, 15.0),
          Key1("Skills", 17.0),
          Value(
              applicant.Skills.toString()
                  .substring(1, applicant.Skills.toString().length - 1),
              15.0),
          Key1("Experiences", 17.0),
          DoubleListValues(
              applicant.ExperienceInFeild, applicant.ExperienceOfFeild)
        ]),
      ),
    );
  }
}
