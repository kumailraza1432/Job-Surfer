import 'package:admin/Classes/Admin.dart';
import 'package:admin/CustomWidgets/JS_AppBar.dart';
import 'package:admin/CustomWidgets/txtfeilds.dart';
import 'package:flutter/material.dart';
import '../Variables.dart';
class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  Admin admin = Admin();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JS_AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          JsTextFeildIconed("User Name", userName, Icon(Icons.person)),
          JsTextFeildIconed("Password", password, Icon(Icons.password)),
          FlatButton(
              onPressed: ()async{
                if(await admin.login(userName.text,password.text,context)) {
                  print("Login Successful");
                  Navigator.pushNamed(context, "/AdminLoggedInScreen",arguments: {"admin": admin,});
              } else {
                print("login failed");
              }
            },
              child: Text("Login"),
              color: colorThird_G,
          )
        ],
      ),
    );
  }
}
