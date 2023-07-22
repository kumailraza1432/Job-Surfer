import 'package:admin/Classes/Employer.dart';
import 'package:admin/Classes/MySQL.dart';
import 'package:mysql1/mysql1.dart';
import 'Applicant.dart';
import 'JobAd.dart';

class Admin {
  late int CNIC;
  late String Name;
  late String DOB;
  late String ContactNumber;
  late String UserName;

  Future<bool> login(userName,password,context)async{
    var results = await MySQL.query("Select * from sql6459853.User natural join sql6459853.Admin where UserName='$userName' and Password= '$password';", context);
    if((results is bool/* no internet */) || results.length==0) return false;// Login Failed
    results = results.first; // selecting first row from the returned table
    CNIC = results[0];
    Name = results[1];
    DOB = results[2];
    ContactNumber = results[3];
    UserName = results[5];
    return true;//Login successfully
  }

  Future<List<Applicant>> searchApplicants(String keyword,context) async{
    List<Applicant> applicants=[];
    var rows = await MySQL.query(
        "select * from sql6459853.User where cnic  = any (SELECT CNIC FROM "
            "sql6459853.Applicant natural join sql6459853.User where username Like '%$keyword%' "
            "union SELECT CNIC FROM sql6459853.Applicant natural join sql6459853.User where name Like '%$keyword%')",context);
    for (var row in rows) {
      Applicant a1 = Applicant.one(row[0], row[1], row[5], "row[5]", row[2], row[3]);
      await a1.getSkills(context);
      applicants.add(a1);}  print(applicants);
    return applicants;
  }

  Future<List<Employer>> searchEmployers(String keyword,context) async{
    List<Employer> employers=[];
    var rows = await MySQL.query(
        "select * from sql6459853.User where cnic  = any (SELECT CNIC FROM "
            "sql6459853.Employer natural join sql6459853.User where username Like '%$keyword%'"
            "union SELECT CNIC FROM sql6459853.Employer natural join sql6459853.User where name Like '%$keyword%')",context);
    for (var row in rows) {
      Employer a1 = Employer.one(row[0], row[1], row[5], "row[5]", row[2], row[3]);
      //await a1.getSkills(context);
      employers.add(a1);}  print(employers);
    return employers;
  }

  Future<dynamic> viewApplicant(CNIC,context) async {
    var results = await MySQL.query(
        "SELECT * FROM sql6459853.User natural join sql6459853.Applicant where CNIC = '$CNIC';",
        context);
    if (results is bool) return false;
    Applicant applicant = Applicant.one(
        results.first[0], results.first[1], results.first[2], results.first[5],
        results.first[4], results.first[6]);
    await applicant.getSkills(context);
    return applicant;
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
        (results as Results).first[13],(results as Results).first[0],));
    } print("\n\n\n\n"+adIDs.toString());
    return jobAds;
    // } catch(e){Navigator.pop(context) ; return jobAds;}
  }
}