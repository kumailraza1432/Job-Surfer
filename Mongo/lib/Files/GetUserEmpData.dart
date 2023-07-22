import '../Classes/Employer.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../CustomWidgets/txtfeilds.dart';
import 'package:flutter/material.dart';

import '../Variables.dart';


class GetUserEmpData extends StatefulWidget {
  const GetUserEmpData({Key? key}) : super(key: key);

  @override
  _GetUserEmpDataState createState() => _GetUserEmpDataState();
}

class _GetUserEmpDataState extends State<GetUserEmpData> {
  Employer employer=Employer();
  List<TextEditingController> c = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

  @override
  Widget build(BuildContext context) {
    Map m= ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
    appBar: JS_AppBar(),
      body: SingleChildScrollView(child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Key1("Contact Number*", 15),
        JsTextFeildNumbers("03xx-xxxxxxx", c[0]),
        Key1("Company Name", 15),
        JsTextFeild("LumionSoft", c[1]),
        Key1("City*", 15),
        JsTextFeild("Islamabad", c[2]),
        Key1("Street*", 15),
        JsTextFeild("Street 4", c[3]),
        Key1("House Number*", 15),
        JsTextFeild("house # 5", c[4]),
        Key1("Postal Code*", 15),
        JsTextFeildNumbers("1023", c[5]),
        Key1("Password*", 15),
        JsTextFeild("", c[6]),

      ],)),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        if(c[0].text.length<1 ||c[2].text.length<1 ||c[3].text.length<1 ||c[4].text.length<1 ||c[6].text.length<1 ||int.tryParse(c[5].text)==null ) {
          showMsg(msg: "Invalid entry, please make sure all entries are correct and complete",context: context); return;}
        Navigator.pushNamed(context, "/Spinner");
        c[1].text=c[1].text.length>0?c[1].text:"None";
        await employer.signUp(m["CNIC"],m["name"],m["userName"],m["DOB"],c[0].text,c[1].text,
            {"City":c[2].text, "Street":c[3].text,"HouseNmuber":c[4].text,"PostalCode":int.parse(c[5].text)},c[6].text);
        Navigator.popUntil(context,ModalRoute.withName('/LoginPage'));
        Navigator.pushReplacementNamed(context, "/LoginPage");
        showMsg(title: "Message",msg: "Account created successfully",context: context);

      },
        child: Icon(Icons.done),),
    );
  }
}
