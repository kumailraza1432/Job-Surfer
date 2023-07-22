import '../Classes/Employer.dart';
import '../Classes/Address.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../CustomWidgets/txtfeilds.dart';

import '../CustomWidgets/JS_AppBar.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<TextEditingController> c = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];
  late Employer employer;
  late Function setPreScreen;

  @override
  Widget build(BuildContext context) {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map;
    employer=m1["employer"];
    setPreScreen=m1["setPreScreen"];
    c[0].text= employer.ContactNumber;
    c[1].text= employer.CompanyName;
    c[2].text= employer.Address.City;
    c[3].text= employer.Address.Street;
    c[4].text= employer.Address.HouseNumber;
    c[5].text= employer.Address.postelCode.toString();
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
        JsTextFeildNumbers("1023", c[5])

      ],)),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        if(c[0].text.length<1 ||c[2].text.length<1 ||c[3].text.length<1 ||c[4].text.length<1 ||int.tryParse(c[5].text)==null ) {
          showMsg("Invalid entry, please make sure all entries are correct and complete",context); return;}
        Navigator.pushNamed(context, "/Spinner");
        await employer.updateProfile(c,context);
        Navigator.pop(context);
        Navigator.pop(context);
        setPreScreen((){});
      },
      child: Icon(Icons.done),),
    );
  }
}

showMsg(msg,context){showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Invalid Entry"),
      content: Text(
          "$msg"),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Okay."))
      ],
    ));
}