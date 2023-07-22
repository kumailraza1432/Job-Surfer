import 'package:admin/Classes/Employer.dart';
import 'package:admin/Files/AdminLoggedIn.dart';
import 'package:admin/Files/AdminProfile.dart';
import 'package:admin/Files/ApplicantProfileAtView.dart';
import 'package:admin/Files/EmployerProfileAtView.dart';
import 'package:admin/Files/SearchApplicant.dart';
import 'package:admin/Files/SearchEmployer.dart';
import 'package:admin/Files/Spinner.dart';
import 'package:admin/Files/ViewAds.dart';
import 'package:flutter/material.dart';
import './Files/AdminLogin.dart';
import './Variables.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: colorThird_G)
      ),
      initialRoute: "/AdminLogin",
      routes: {
        "/AdminLogin": (context) => AdminLogin(),
        "/Spinner": (context) => Spinner(),
        "/AdminLoggedInScreen": (context) => AdminLoggedInScreen(),
        "/AdminProfile": (context) => AdminProfile(),
        "/SearchApplicant": (context) => SearchApplicant(),
        "/SearchEmployer": (context) => SearchEmployer(),
        "/ApplicantProfileAtView": (context) => ApplicantProfileAtView(),
        "/EmployerProfileAtView": (context) => EmployerProfileAtView(),
        "/ViewAds": (context) => ViewAds(),
      },
    );
  }
}
