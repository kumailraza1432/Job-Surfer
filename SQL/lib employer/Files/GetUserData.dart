import 'package:Employer/Classes/Employer.dart';

import '../Classes/MySQL.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../CustomWidgets/txtfeilds.dart';
import 'package:flutter/material.dart';

import '../Variables.dart';

class GetUserData extends StatefulWidget {
  const GetUserData({Key? key}) : super(key: key);

  @override
  _GetUserDataState createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
   Employer employer = Employer();
  List<TextEditingController> c=[TextEditingController(),TextEditingController(),TextEditingController()];
  @override
  Widget build(BuildContext context) {
    Map m= ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
          child:Column(children: [
            JsTextFeild("User Name", c[0]),
            JsTextFeild("Name eg Madara Uchia", c[1],),
            JsTextFeild("Date Of Birth, eg 2020-12-29", c[2],helperText: "Format yyyy-mm-dd"),
            FlatButton(color: colorThird_G,onPressed: ()async{
                var rows = await MySQL.query("Select count(*) from sql6459853.User where UserName='${c[0].text}'", context) ;
                if(rows.first[0]>0) {showMsg(msg: "User name already exists, try a another, unique one",context: context);
                  return;}
                employer.userName=c[0].text;
                employer.Name=c[1].text;
                employer.DateOfBirth=c[2].text;
                Navigator.pushReplacementNamed(context, "/GetUserEmpData",arguments: {"CNIC":m["CNIC"],"userName":employer.userName,"name":employer.Name,"DOB":employer.DateOfBirth});
            }, child: Text("Next",style: TextStyle(fontSize: 20),),)
      ],)),

    );
  }
}
