/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Employer class
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

import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';
import './Applicant.dart';
import './Application.dart';
import './Address.dart';
import 'User.dart';
import 'Address.dart';
import 'MySQL.dart';
import 'JobAd.dart';

class Employer extends User{

  String _CompanyName="";
   List<JobAd> JobAds=[];
  static bool LoggedIn= false;


  Employer();

  //this method searches the given credentials, of th employer, in the database, if employer authenticates, it
  //stores it in the objects and return true; else it return false
  Future<bool> login(String username, password,context) async {
   Results results = await MySQL.query("SELECT * FROM sql6459853.User natural join sql6459853.Employer where Password='$password' and UserName = '$username';",context);
    if(results.isEmpty) return false; //login failed
    for(var row in results) {
      CNIC = row[0];
      Name = row[1];
      super.userName = row[5];
      DateOfBirth = row[2];
      super.Address = await Address.getAddress(row[4],context);
      ContactNumber = row[3];
      _CompanyName = row[6];
    }
    return LoggedIn=true; // sets LoggedIn to true, and return true
  }


  Future<dynamic> deleteJobAd(JobID,context) async{
    if (await MySQL.query("DELETE FROM `sql6459853`.`JobAd` WHERE (`JobAdID` = '$JobID');",context,removePreContext: false) is bool)
      return false; // if no internet connection, else return void
  }

  // it returns all the ads, posted by this employeer, after retiring them from the database
  Future<dynamic> viewJobAds(context) async {
      JobAds.clear(); // removes all the adds from the list, because it is possible that if we don't
      // clear it, it might retain deleted or un-updated ads
      dynamic results = await MySQL.query("SELECT * FROM sql6459853.JobAd where CNIC='$CNIC';",context);
      if( results is bool) return;//no internet
        for(var row in results){
          JobAd j1 = JobAd(row[8], row[1], row[2], row[3], row[4], row[5], row[0], row[6], [], [],row[7]);
          await j1.getSkills(context);
          await j1.getResponsibilities(context);
          JobAds.add(j1);
        }
        return JobAds;
  }
  Employer.one(int CNIC, String Name, String UserName, Address Address, String DateOfBirth, String ContactNumber, this._CompanyName) : super.one(CNIC, Name, UserName, Address, DateOfBirth, ContactNumber);

  @override
  String toString() {
    return 'Employer{_CompanyName: $_CompanyName}'+super.toString();
  }

  String get CompanyName => _CompanyName;

  void setCompanyName(String value) {
    _CompanyName = value;
  }

  Future<void> addJobAd(JobAd jobAd,context) async {
    if(await MySQL.query("INSERT INTO `sql6459853`.`JobAd` (`Description`, "+
        "`ExpireDate`, `PostedDate`, `SalaryFrom`, `SalaryTo`, `RequiredExperience`, `CNIC`, "+
        "`Title`) VALUES ('${jobAd.Description}', '${jobAd.ExpireDate}', '${jobAd.PostedDate}', ${jobAd.SalaryFrom},"
        +" ${jobAd.SalaryTo}, ${jobAd.RequiredExperience}, ${CNIC}, '${jobAd.Title}');",context) is bool)
      return; // if no internet connection, the rest queries won't be forward to the database
    var r = await MySQL.query("Select Max(JobAdId) from `sql6459853`.`JobAd` ;",context); // retrieving the
    // auto generated id of the last added ad
    for(var row in r ) jobAd.JobID= row[0]; // storing the retrieved id in the object
    await jobAd.addSkills(jobAd.SkillsRequired,context); // add skills against the ad
    await jobAd.addResponsibilities(jobAd.Responsiibilitie,context); // adding responsibilities against the add
  }

  Future<dynamic> editJobAd(JobAd ad,context) async {
    try { // if there is internet connection
      print("done1");
      if ((await MySQL.query("UPDATE `sql6459853`.`JobAd` SET `Description` = '${ad.Description}', "
          "`ExpireDate` = '${ad.ExpireDate}', `SalaryFrom` = '${ad.SalaryFrom}', `SalaryTo` = '${ad.SalaryTo}',"
          " `RequiredExperience` = '${ad.RequiredExperience}', `Title` = '${ad.Title}'"
          " WHERE (`JobAdID` = '${ad.JobID}');",context,callingEditADD: true)) is bool) return false; // no internet connection, so rest won't be executes
      print("done2");
      // this function will first  remove all the
      // responsibilities, and then update them
       await ad.addResponsibilities(ad.Responsiibilitie,context);
      // this function will first  remove all the
      // skills, and then update them
        await ad.addSkills(ad.SkillsRequired,context);
        return true; // executed successfully
    } on Exception catch (e) {} // do nothing
}

  Future<List<Applicant>> searchApplicants(List<String> paras,context) async{
    Set<int> applicants = Set();
    Map<dynamic,dynamic> applicantObjects = Map();
    applicantObjects.addAll({"initialized": false});
    List<dynamic> result = await iterateParams(applicants,applicantObjects,paras,context); //filters the applicants, based on paras (parameters); stores the filtered applicant's
    applicants=result[0];
    applicantObjects=result[1];
    // CNICs into the set (Applicant),and the objects in the Map (applicantObjects )
    return applicants_MapToList(applicants,applicantObjects); //retrives the filtered applicants objects,
    // based on their CNICs, and returns the list of Applicant
  }

  //this method takes the reference of a set (applicants), a map (applicantObjects), and parameters, searches
  // parameters, one by on, in the database; store all the objects in the map (applicantObjects), stored the applicantObjects (CNIC)
  // of filtered applicants into set (applicants), and returns the applicants and applicantObjects as a list
  Future<List<dynamic>> iterateParams(applicants,applicantObjects,paras,context)async{
    for(var para in paras){
      para=para.trim(); // removing the starting and ending spaces, as spaces can cause anomalies
      // in the  search, since two same string won't be equal if one has an extra starting or ending space
      if(para.length>0){ // if the parameter is not null,
        Set<int> parameterResult = Set();
        await updateSearch(parameterResult, applicantObjects,para,context);
        if(!applicantObjects["initialized"]) {
          applicantObjects["initialized"]=true; // for the first search parameter, we will store the resultant applicant its
          // in the applicants list, after the first parameter, we will intersect the result of the current
          // parameter from the results of the last parameters(Applicant list), in order to
          // filter applicants, based on the parameters
          applicants = applicants.union(parameterResult);
        } else applicants = applicants.intersection(parameterResult);}}
    return [applicants,applicantObjects];
}

  //This method takes a single para (parameter), search the applicants based on that parameter,
  // stores the object in applicantObjects (map), and CNICs in the parameterResult
  Future<void> updateSearch(parameterResult, applicantObjects,para,context)async {
    var rows = await MySQL.query(
        "select * from sql6459853.User where cnic  = any (SELECT CNIC FROM "+
       " sql6459853.Applicant natural join sql6459853.User where username Like '%$para%' union SELECT CNIC "+
      "FROM sql6459853.Applicant natural join sql6459853.User where name Like '%$para%' union SELECT "+
      "CNIC FROM sql6459853.Skills_has_Applicant natural join sql6459853.Skills where SkillName Like '%$para%') ",context);
    for (var row in rows) {
      Applicant a1 = Applicant.one(row[0], row[1], row[5], await Address.getAddress(row[4], context), row[2], row[3]);
      await a1.getQualifications(context);
      await a1.getSkills(context);
      await a1.getExperience(context);
      applicantObjects.addAll({row[0]: a1});
      parameterResult.add(row[0]);}}

  // This method takes an set (applicants),containing CNICs of applicants, and using those sets, selects filtered applicants form the applicantObjects map
  List<Applicant> applicants_MapToList(applicants,applicantObjects){
    List<Applicant> list = [];
    applicantObjects.forEach((key, value) {
      if(applicants.contains(key)) list.add(value);} );
    return list;
  }

  Future<dynamic> viewApplicant(CNIC,context) async {
    var results = await MySQL.query(
        "SELECT * FROM sql6459853.User natural join sql6459853.Applicant where CNIC = '$CNIC'",
        context);
    if (results is bool) return false;
    Applicant applicant = Applicant.one(
        results.first[0], results.first[1], results.first[5], await Address.getAddress(results.first[4],context),
        results.first[2], results.first[3]);
    await applicant.getQualifications(context);
    await applicant.getSkills(context);
    await applicant.getExperience(context); print("-------------------"+applicant.Experience.toString());
    return applicant;
  }

  Future<dynamic> viewApplications(adID,context,responded)async{
    var results;
    if(responded) results =await MySQL.query("select * from `sql6459853`.`Application` natural join  `sql6459853`.`User` where JobAdID='$adID' and Status <> 'Not Responded';",context,removePreContext: false);
    else  results =await MySQL.query("select * from `sql6459853`.`Application` natural join  `sql6459853`.`User` where JobAdID='$adID' and Status = 'Not Responded';",context,removePreContext: false);
    if(results is bool) return;//no internet
    List<Application> applications=[];
    for(var row in results) applications.add(Application(row[1], row[5], row[2], row[3], row[0], row[4]));
    return applications;
  }

  Future<dynamic> respondToApplication(ApplicationID,status,note,context)async{
    var results =await MySQL.query("UPDATE `sql6459853`.`Application` SET `EmployerNote` = '$note', `Status` = '$status' WHERE (`ApplicationID` = '$ApplicationID');",context);
    if(results is bool) return results; //no internet
    List<Application> applications=[];
    for(var row in results) applications.add(Application(row[1], row[5], row[2], row[3], row[0], row[4]));
    return applications;

  }
  Future<dynamic> signUp(cnic,name,username,dob,c,context) async{
    print("________"+cnic.toString()+" "+name+username+" "+dob);
    var results = await MySQL.query("INSERT INTO `sql6459853`.`User` (`CNIC`, `Name`, `DateOfBirth`, `UserName`) VALUES ('$cnic', '$name', '$dob', '$username');", context);
    if(results is bool) return;
    results = await MySQL.query("INSERT INTO `sql6459853`.`Employer` (`CNIC`) VALUES ('$cnic');", context);
    if(results is bool) return;
    return await addProfileData(cnic,c, context);
  }
  Future<dynamic> addProfileData(CNIC,List<TextEditingController> c,context) async{
    var result = await MySQL.query("UPDATE `sql6459853`.`User` SET `ContactNumber` = '${c[0].text}' WHERE (`CNIC` = '$CNIC');", context);
    if(result is bool) return false;
    result = await MySQL.query("UPDATE `sql6459853`.`Employer` SET `CompanyName` = '${c[1].text}', `Password` = '${c[6].text}' WHERE (`CNIC` = '$CNIC');", context);
    if(result is bool) return false;
    result = await MySQL.query("select AddressID from sql6459853.Address where City = '${c[2].text}' and  `Street` = '${c[3].text}' and  `HouseNumber` = '${c[4].text}' and `PostalCode` = '${c[5].text}';", context);
    print(result.toString());
    if(result.length>0)if(result.first[0] is int ) if(result.first[0]>0)
    {this.Address=await Address.getAddress(result.first[0], context); await MySQL.queryDuplication("UPDATE `sql6459853`.`User` SET `AddressID` = '${result.first[0]}' WHERE (`CNIC` = '$CNIC');", context);
    this._CompanyName=c[1].text;this.ContactNumber=c[0].text;return; }
    await MySQL.query("INSERT INTO `sql6459853`.`Address` (`City`, `Street`, `HouseNumber`, `PostalCode`) VALUES ('${c[2].text}', '${c[3].text}', '${c[4].text}', '${c[5].text}');", context);
    result = await MySQL.query("select AddressID from sql6459853.Address where City = '${c[2].text}' and  `Street` = '${c[3].text}' and  `HouseNumber` = '${c[4].text}' and `PostalCode` = '${c[5].text}';", context);
    print(result.toString());
    if(result.length>0)if(result.first[0] is int ) if(result.first[0]>0)
    {this.Address=await Address.getAddress(result.first[0], context); await MySQL.queryDuplication("UPDATE `sql6459853`.`User` SET `AddressID` = '${result.first[0]}' WHERE (`CNIC` = '$CNIC');", context);
    this._CompanyName=c[1].text;this.ContactNumber=c[0].text;return; }

    print(c[2].text);
  }
  Future<dynamic> updateProfile(List<TextEditingController> c,context) async{
    var result = await MySQL.query("UPDATE `sql6459853`.`User` SET `ContactNumber` = '${c[0].text}' WHERE (`CNIC` = '$CNIC');", context);
    if(result is bool) return false;
    result = await MySQL.query("UPDATE `sql6459853`.`Employer` SET `CompanyName` = '${c[1].text}' WHERE (`CNIC` = '$CNIC');", context);
    if(result is bool) return false;
    result = await MySQL.query("select AddressID from sql6459853.Address where City = '${c[2].text}' and  `Street` = '${c[3].text}' and  `HouseNumber` = '${c[4].text}' and `PostalCode` = '${c[5].text}';", context);
    print(result.toString());
    if(result.length>0)if(result.first[0] is int ) if(result.first[0]>0)
    {this.Address=await Address.getAddress(result.first[0], context); await MySQL.queryDuplication("UPDATE `sql6459853`.`User` SET `AddressID` = '${result.first[0]}' WHERE (`CNIC` = '$CNIC');", context);
    this._CompanyName=c[1].text;this.ContactNumber=c[0].text;return; }
    await MySQL.query("INSERT INTO `sql6459853`.`Address` (`City`, `Street`, `HouseNumber`, `PostalCode`) VALUES ('${c[2].text}', '${c[3].text}', '${c[4].text}', '${c[5].text}');", context);
    result = await MySQL.query("select AddressID from sql6459853.Address where City = '${c[2].text}' and  `Street` = '${c[3].text}' and  `HouseNumber` = '${c[4].text}' and `PostalCode` = '${c[5].text}';", context);
    print(result.toString());
    if(result.length>0)if(result.first[0] is int ) if(result.first[0]>0)
    {this.Address=await Address.getAddress(result.first[0], context); await MySQL.queryDuplication("UPDATE `sql6459853`.`User` SET `AddressID` = '${result.first[0]}' WHERE (`CNIC` = '$CNIC');", context);
    this._CompanyName=c[1].text;this.ContactNumber=c[0].text;return; }

    print(c[2].text);
  }
 }
