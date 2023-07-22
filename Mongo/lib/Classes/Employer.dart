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
import 'package:mongo_dart/mongo_dart.dart';
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
  int postedAds=0;
   List<JobAd> JobAds=[];
  static bool LoggedIn= false;


  Employer();

  //this method searches the given credentials, of th employer, in the database, if employer authenticates, it
  //stores it in the objects and return true; else it return false
  Future<bool> login(String username, password,[context=3]) async {
    var db = await Db.create('mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
    await db.open();
    var coll = await db.collection('Employers');
    List<Map> l1=[];
    l1= (await coll.find({"UserName":username, "Password":password}).toList()); //.map((event) => l1.add(event));
    //print(l1.first);
    var value = (l1.isEmpty)?false:l1.first;
    if (value is bool) {
   db.close();   return false;
    }
    value = value as Map;
      CNIC = value['CNIC'];print("okkk1");
      Name = value['Name'];print("okkk2");
      super.userName = value['UserName'];print("okkk3");
      DateOfBirth = value['DateOfBirth'];print("okkk4");
      super.Address = Address.name(value["Address"]["City"],value["Address"]["Street"],value["Address"]["HouseNmuber"],value["Address"]["PostalCode"]);print("okkk");
      ContactNumber = value['ContactNumber'];print("okkk");
      _CompanyName = value['CompanyName'];print("okkk");
    await db.close();
    print("Done---");
    return LoggedIn=true; // sets LoggedIn to true, and return true
  }


  Future<dynamic> deleteJobAd(JobID,[context=1]) async{
    var db = await Db.create('mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
    await db.open();
    var coll = await db.collection('JobAds');
    await coll.deleteOne({"_id":JobID}); //.map((event) => l1.add(event));

    print("Dne");
    db.close();
  }

  // it returns all the ads, posted by this employeer, after retiring them from the database
  Future<dynamic> viewJobAds([context=3]) async {
      JobAds.clear(); // removes all the adds from the list, because it is possible that if we don't
      // clear it, it might retain deleted or un-updated ads
      var db = await Db.create('mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
      await db.open();
      var coll = await db.collection('JobAds');
      List<Map> l1=[];
      l1= (await coll.find({"PostedBy":CNIC}).toList());
      print(l1);
      for(var row in l1){
        List<String> skills=[];
        List<String> responsibilities=[];
        for(var e in (row["SkillsRequired"] as List)) { skills.add(e.toString()); print(e); }
      for (var e in (row["Responsibilities"] as List)) responsibilities.add(e.toString());
          JobAd j1 = JobAd(row["Title"], row["Description"], row["ExpireDate"], row["PostedDate"], row["SalaryFrom"], row["SalaryTo"], row["_id"], row["RequiredExperience"] ,skills,responsibilities );
          JobAds.add(j1);
        }
      db.close();
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

  Future<void> addJobAd(JobAd jobAd) async {
    var db = await Db.create(
        'mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
    await db.open();
    var coll = await db.collection('JobAds');
    await coll.insertOne({
      "PostedBy":jobAd.PostedBy,
      "Title":jobAd.Title,
      "Description":jobAd.Description,
      "ExpireDate":jobAd.ExpireDate,
      "PostedDate":jobAd.PostedDate,
      "SalaryFrom":jobAd.SalaryFrom,
      "SalaryTo":jobAd.SalaryTo,
      "RequiredExperience":jobAd.RequiredExperience,
      "SkillsRequired":jobAd.SkillsRequired,
      "Responsibilities":jobAd.Responsiibilitie
    });
      }

  Future<dynamic> editJobAd(JobAd ad,[context=1]) async {
    print(ad);
      var db = await Db.create(
          'mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
      await db.open();
      var coll = await db.collection('JobAds');
      List<Map> l1 = [];
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("Title", ad.Title));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("Description", ad.Description));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("ExpireDate", ad.ExpireDate));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("PostedDate", ad.PostedDate));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("SalaryFrom", ad.SalaryFrom));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("SalaryTo", ad.SalaryTo));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("RequiredExperience", ad.RequiredExperience));
      await   coll.updateOne(where.eq('_id', ad.JobID), modify.set("SkillsRequired", ad.SkillsRequired));
print("d11111111");
    db.close();
    return true;

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
  Future<dynamic> signUp(cnic,name,username,dob,contactno,companyName,address,password,) async{
    var db = await Db.create('mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
    await db.open();

    var coll = await db.collection('Employers');
    //var value1 =  await coll.find({"UserName":userName});
    //var value = !(await value1.isEmpty)?false:value1.first;
    //if(value is bool) return false;
    //coll = await db.collection('Employers');
    await coll.insertOne({
      "CNIC":cnic,
      "DateOfBirth":dob,
      "ContactNumber":contactno,
      "Address":address,
      "CompanyName":companyName,
      "Name":name,
      "UserName":username,
      "Password":password
    });
    print(true);
    db.close();

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
