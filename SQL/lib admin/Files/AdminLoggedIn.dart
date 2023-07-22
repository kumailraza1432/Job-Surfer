import 'package:admin/Classes/Admin.dart';
import 'package:admin/CustomWidgets/TextIconButton.dart';
import 'package:flutter/material.dart';
import '../Variables.dart';
import '../CustomWidgets/JS_AppBar.dart';

class AdminLoggedInScreen extends StatefulWidget {
  const AdminLoggedInScreen({Key? key}) : super(key: key);

  @override
  _AdminLoggedInScreenState createState() => _AdminLoggedInScreenState();
}

class _AdminLoggedInScreenState extends State<AdminLoggedInScreen> {
  //This method loads the data into, of employer, from the database.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  late Admin admin; // = Admin();

  @override
  Widget build(BuildContext context) {
    Map m = ModalRoute.of(context)!.settings.arguments as Map ;
    admin = m["admin"];
    return Scaffold(
        appBar: JS_AppBar(),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 220,
                        width: 270,
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0))),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 5, 2),
                    child: TextIconButtom(() {
                      Navigator.pushNamed(context, "/AdminProfile",arguments: {"admin": admin,});
                      },
                        Icons.account_circle_outlined, 90.0, colorThird_G, "Profile"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 5, 2),
                    child: TextIconButtom(() async {
                      Navigator.pushNamed(context, "/SearchApplicant",arguments: {"admin":admin,});
                      },
                        Icons.work_outline, 90.0, colorThird_G, "View Applicants"),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 5, 2),
                    child: TextIconButtom(() async{
                      Navigator.pushNamed(context, "/SearchEmployer",arguments: {"admin":admin,});
                    },
                        Icons.email_outlined, 90.0, colorThird_G, "View Employers"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 5, 2),
                    child: TextIconButtom(() async{
                      Navigator.pushNamed(context, "/ViewAds",arguments: {"admin":admin,});
                    },
                        Icons.ad_units_rounded, 90.0, colorThird_G, "View Ads"),
                  ),]
                ,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 5, 2),
                    child: TextIconButtom(() {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to log out?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, "/AdminLogin",arguments: {"admin": admin,});
                                  },
                                  child: Text("Yes", style: TextStyle(color: colorThird_G),)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);}, child: Text(
                                "No",
                                style: TextStyle(color: colorThird_G),)
                              )
                            ],
                          ));
                    }, Icons.login_outlined, 90.0, colorThird_G,
                        "Logout"),
                  ),
                ],
              )
            ],
          )
      )
    );
  }
}