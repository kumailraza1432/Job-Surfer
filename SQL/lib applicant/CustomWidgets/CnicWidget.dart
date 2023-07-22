import '../Classes/Employer.dart';

import '../Classes/MySQL.dart';
import '../CustomWidgets/txtfeilds.dart';
import 'package:flutter/material.dart';

import '../Variables.dart';

class CNICWidget extends StatefulWidget {
  const CNICWidget({Key? key}) : super(key: key);

  @override
  _CNICWidgetState createState() => _CNICWidgetState();
}

class _CNICWidgetState extends State<CNICWidget> {
  TextEditingController CNIC=TextEditingController();
  Employer employer=Employer();
  @override
  Widget build(BuildContext context) {
    return Center(child:SingleChildScrollView(child:
    Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       JsTextFeild("CNIC", CNIC),
      Center(child: FlatButton(onPressed: ()async{
         if(!(int.tryParse(CNIC.text)==null)){
           Navigator.pushNamed(context, "/Spinner");
            var rows =await MySQL.query("select count(*) from sql6459853.User where CNIC=${int.parse(CNIC.text)};",context);
            if(rows.first[0]>0) {
              var rows1 =await MySQL.query("select count(*) from sql6459853.Employer where CNIC=${int.parse(CNIC.text)};",context);
                if(rows1.first[0]>0) {
                  Navigator.pop(context);
                  showMsg(title: "Error",msg: "Employer Already exists",context: context);}
                else{Navigator.pop(context); }
            }//go to company name psword
            else{Navigator.pop(context);employer.CNIC=int.parse(CNIC.text);print(employer.CNIC); Navigator.pushReplacementNamed(context, "/GetUserData",arguments: {"CNIC":employer.CNIC}); }

            ;}
            else showMsg(title: "Error",msg: "Enter text",context: context);
            }, color: colorThird_G,child: Text("Next",style: TextStyle(backgroundColor: colorThird_G,color: Colors.white,fontSize: 24),),))
      ],

    )));
  }
}
