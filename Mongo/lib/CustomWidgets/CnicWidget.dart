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
          {Navigator.pop(context);employer.CNIC=int.parse(CNIC.text);print(employer.CNIC); Navigator.pushReplacementNamed(context, "/GetUserData",arguments: {"CNIC":employer.CNIC}); }

            ;}
            else showMsg(title: "Error",msg: "Enter text",context: context);
            }, color: colorThird_G,child: Text("Next",style: TextStyle(backgroundColor: colorThird_G,color: Colors.white,fontSize: 24),),))
      ],

    )));
  }
}
