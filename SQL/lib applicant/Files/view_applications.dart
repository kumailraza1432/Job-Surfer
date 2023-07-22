import 'package:applicant/Classes/Applicant.dart';
import 'package:applicant/Classes/Application.dart';
import 'package:applicant/CustomWidgets/JS_AppBar.dart';
import 'package:applicant/CustomWidgets/application_widget.dart';
import 'package:applicant/Variables.dart';
import 'package:flutter/material.dart';

class ApplcationViewScreen extends StatefulWidget {
  ApplcationViewScreen({Key? key}) : super(key: key);

  @override
  _ApplcationViewScreenState createState() => _ApplcationViewScreenState();
}

class _ApplcationViewScreenState extends State<ApplcationViewScreen> {
  loadData()async{
   data =  await applicant.getApplications(context);
   setState(() {
      loading=false;
    });
  }

  late Applicant applicant;
  late List<ApplicationWidget> data=[];
  bool loading=true;
  @override
  Widget build(BuildContext context) {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map;
    applicant = m1['applicant'];
    if(loading){
      loadData();
      return spinner_G;
    }


    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: data)),

    );
  }
}
