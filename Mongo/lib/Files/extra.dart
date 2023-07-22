import 'package:mongo_dart/mongo_dart.dart';

Future<dynamic> totalAds(employer) async{
  var db = await Db.create('mongodb+srv://sabih:sabih123@cluster0.l0yxs.mongodb.net/tst2?retryWrites=true&w=majority');
  await db.open();
  var coll = await db.collection('Employers');
  final pipeline = AggregationPipelineBuilder()
      .addStage(
      Match(where.eq("PostedBy", employer.CNIC).map['\$query']))
      .addStage(
      Group(
           id:  Field('PostedBy'),
          fields: {
            'total': Sum(1)
          }
      )).build();


  // final pipeline = AggregationPipelineBuilder()
  //     .addStage(Lookup(from: "JobAds", localField: "CNIC", foreignField: "PostedBy", as: "JobAds"))
  //     .addStage(Unwind(Field("JobAds")))
  //     .addStage(
  //     Match(where.eq("JobAds.PostedBY", employer.CNIC).map['\$query']))
  //     .addStage(
  //     Group(
  //         id:  Field('\'\$JobAds.PostedBY\''),
  //         fields: {
  //           'total': Sum(1)
  //         }))
  //     .build();
  var result =
  await DbCollection(db, 'JobAds')
      .aggregateToStream(pipeline).toList();
  print(await result);
  db.close();
  return result.isNotEmpty?result.first['total']:0;
}
