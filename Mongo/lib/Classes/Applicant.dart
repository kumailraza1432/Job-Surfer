/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 1,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Applicant class
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
import '../Classes/qualific.dart';
//import '../CustomWidgets/application_widget.dart';
import '../Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import './MySQL.dart';
import 'Address.dart';
import "User.dart";


class Applicant extends User {
  Map<String,String> _Experience = {};
  List<String> _Skills = [];
  late List<Qualification_> _Qualification_;
  bool LoggedIn=false;
  Applicant.one(int CNIC, String Name, String UserName, Address Address,
      String DateOfBirth, String ContactNumber)
      : super.one(CNIC, Name, UserName, Address, DateOfBirth, ContactNumber);

  // getApplications(context)async{
  //   List<ApplicationWidget> list=[];
  //   var r = await MySQL.query("SELECT username,Status,Title,EmployerNote FROM ( Select JobAdID,EmployerNote,Status from sql6459853.Application where CNIC=1111) as a natural join sql6459853.JobAd natural join sql6459853.User ;", context,removePreContext: false);
  //   if(r is bool ) {
  //     return list;
  //   }
  //   for(var row in r) list.add(ApplicationWidget(row[0], row[1], row[2], row[3])) ;
  //   return list;
  // }


  getQualifications(context)async{
    List<Qualification_> list=[];
    var r = await MySQL.query("SELECT QualificationID,Institute,YearFrom,YearTo,Field,Type FROM sql6459853.Qualification natural join Applicant_has_Qualification natural join User where CNIC =$CNIC;", context,removePreContext: false);
    if(r is bool ) {
      return list;
    }
    for(var row in r) list.add(Qualification_.one(row[0], row[1], row[2], row[3], row[4], row[5])) ;
    this._Qualification_=list;
  }


  Applicant() : super();
  getExperience(context) async {
    var rows = await MySQL.query("SELECT Field,Duration FROM sql6459853.Applicant natural join sql6459853.Applicant_has_Experience natural join sql6459853.Experience where cnic='$CNIC';", context);
    print(rows);
    if(rows is bool || rows.isEmpty ) return false; //no internet
    for(var row in rows) this.Experience.addAll({row[0].toString():row[1].toString()});
  }

  Future<bool> login(String username, password,context) async {
    Results results = await MySQL.query("SELECT * FROM sql6459853.User natural join sql6459853.Applicant where Password='$password' and UserName = '$username';",context);
    if(results.isEmpty) return false; //login failed
    for(var row in results) {
      CNIC = row[0];
      Name = row[1];
      super.userName = row[5];
      DateOfBirth = row[2];
      super.Address = await Address.getAddress(row[4],context);
      ContactNumber = row[3];
      await getSkills(context);
      await getExperience(context);
      await getQualifications(context);
    }
    return LoggedIn=true; // sets LoggedIn to true, and return true
  }


  List<String> get Skills => _Skills;

  Map<String, String> get Experience => _Experience;

  set Experience(Map<String, String> value) {
    _Experience = value;
  }

  List<Qualification_> get Qualification => _Qualification_;

  set Qualification(List<Qualification_> value) {
    _Qualification_ = value;
  }

  set Skills(List<String> value) {
    _Skills = value;
  }
  // This method retrieves the skills, of the applicant has, from the database;
  // and stored them in the object
  Future<void> getSkills(context) async {
    if (Skills.length > 0) Skills.clear();
    var rows = await MySQL.query(
        "Select SkillName from `sql6459853`.`Skills_has_Applicant` natural join sql6459853.Skills where cnic = $CNIC;",context);
    if(! rows.isEmpty)for (var row in rows) Skills.add(row[0]);
    else Skills.add("None");
  }

  Future<dynamic> searchJobAds(context,input)async {
    List<JobAd> jobAds = [];
   //  try{
      var params = input.split(','); print(params);
      Set<int> adIDs = {};
      for (var param in params) {
        var results = await MySQL.query(
            "SELECT distinct JobAdID FROM sql6459853.JobAd natural join sql6459853.JobAd_has_Skills natural join sql6459853.User natural join sql6459853.Skills where Title like '%$param%' or skillName like '%$param%';",
            context);
        if (results is bool) return false;
        if((results as Results).isNotEmpty)
          for(var rows in results) adIDs.add(rows[0]);
      }
      for (int adID in adIDs) {
        var results = await MySQL.query(
            "SELECT * FROM sql6459853.JobAd natural join sql6459853.User where JobAdId=$adID;",
            context);
        if (results is bool) return false;
        if((results as Results).isNotEmpty) jobAds.add(JobAd(
            (results as Results).first[8],
            (results as Results).first[2],
            (results as Results).first[3],
            (results as Results).first[4],
            (results as Results).first[5],
            (results as Results).first[6], (results as Results).first[1],
            (results as Results).first[7],
            await JobAd.StaticGetSkills(adID, context),
            await JobAd.staticGetResponsibilities(adID, context),
            (results as Results).first[13]));
      } print("\n\n\n\n"+adIDs.toString());
      return jobAds;
    // } catch(e){Navigator.pop(context) ; return jobAds;}
}

  Future<dynamic> apply(JobAd ad, BuildContext context) async{
    var result= await MySQL.query("SELECT count(*) FROM sql6459853.Application where CNIC=$CNIC and JobAdID=${ad.JobID};", context,removePreContext: false);
    if(result is bool) return false;
    if((result as Results).first[0]>0) {
      showMsg(context: context,
          msg: "You have already applied to this job ad!",
          title: "Failed to apply"); return false;
    }
    await MySQL.query("INSERT INTO `sql6459853`.`Application` (`EmployerNote`, `Status`, `CNIC`, `JobAdID`) VALUES ('None', 'Not Responded', '$CNIC', '${ad.JobID}');", context);
    await MySQL.query("INSERT INTO `sql6459853`.`Notification` (`Year`, `Month`, `Day`, `Title`, `GeneratedBy`, `GeneratedFor`, `Type`) VALUES "
        "('${DateTime.now().year.toString()}', '${DateTime.now().month.toString()}', '${DateTime.now().day.toString()}',"
        " 'Applied to your job ad ${ad.Title} ', '$CNIC', '${ad.PostedBy}', 'Not Viewed');", context);
    showMsg(context: context,msg: "Applied Successfully",title: "Congrats");
  }

}
