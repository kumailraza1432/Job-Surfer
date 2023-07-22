
import 'package:employer_db_mongo/Classes/Employer.dart';
import 'package:employer_db_mongo/Classes/JobAd.dart';
import 'package:mongo_dart/mongo_dart.dart';
main1()async {
  // var db = await Db.create("mongodb+srv://<user>:<password>@<host>:<port>/<database-name>?<parameters>");
  // await db.open();
  //  var db = await Db.create('mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
  // await db.open();
  // var coll = db.collection('tst1');
  //await coll.insert({'ok':2});
  Employer e1= Employer();
  //print(await e1.login("123", "123"));
  print(await e1.login("u11", "pword"));
  //await e1.signUp(123, "u1", "u11", "u22", "u2", {"ok":"82"}, "pword");
  List<JobAd> l1 = await e1.viewJobAds();
  print(l1.length);
  //print( l1.first.JobID.runtimeType);
  l1.first.SkillsRequired=["1","3","3"];
  await e1.editJobAd(l1.first);
  print((await e1.viewJobAds()));

}