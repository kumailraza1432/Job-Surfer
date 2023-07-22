/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 15,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of View Applications stateful widget
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case alphabet
///     -- Global variables should end with _G

import '../Classes/JobAd.dart';
import 'package:flutter/material.dart';
import '../Files/RespondToApplication.dart';
import '../Variables.dart';
import '../Classes/Application.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../CustomWidgets/ApplicationOverview.dart';
import '../Classes/Employer.dart';
class ViewApplications extends StatefulWidget {
  const ViewApplications({Key? key}) : super(key: key);

  @override
  _ViewApplicationsState createState() => _ViewApplicationsState();
}

class _ViewApplicationsState extends State<ViewApplications> {

  var applications= [];
  late Employer employer;
  late JobAd jobAd;

  bool Initilized=false;
  bool spinner=true;
  String StateOfScreen="Not Responded Applications";
  @override
  Future<void> load([responded=false])async {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    employer=m1["employer"];
    jobAd=m1["Ad"];
    applications=await employer.viewApplications(jobAd.JobID, context,responded);
    if(applications is bool ) Navigator.pop(context); // no internet
    Initilized=true;
    setState(() {  spinner=false;  });
  }
  @override
  Widget build(BuildContext context) {

    if(!Initilized) {load(false); }
    if(spinner) return spinner_G;
    var body;
    if(StateOfScreen=="Not Responded Applications") {
      body = applications.map((appli) =>
              ApplicationOverview(context, appli, employer, setState,load,jobAd)).toList();}
    else body=  applications.map((appli) => RespondedApplicationOverview(appli) ).toList();
    if(applications.length==0) body =[Container(child:Padding(padding: EdgeInsets.only(left:100 ),
    child: Value("None",17)))];
        return Scaffold(
        appBar: JS_AppBar(),
        body: SingleChildScrollView(
            child:Column(children:[Container(child:Key1(StateOfScreen,15))]+body
              ,))
        ,floatingActionButton: FloatingActionButton(onPressed: ()async{
         setState(() {spinner=true;});
          var value = StateOfScreen!="Not Responded Applications"? await employer.viewApplications(jobAd.JobID, context,false)
              :await employer.viewApplications(jobAd.JobID, context,true);
          if(!(value is bool)){ // have internet connection
            StateOfScreen=StateOfScreen=="Not Responded Applications"?
          "Responded Applications":"Not Responded Applications";
            applications=value;}
          setState(() {spinner=false;});
          },
          child: Icon(Icons.swap_horiz), backgroundColor: colorThird_G,
        ),

        );

  }
}
