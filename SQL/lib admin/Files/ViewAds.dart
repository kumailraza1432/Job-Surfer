import 'package:admin/Classes/Admin.dart';
import 'package:admin/Classes/JobAd.dart';
import 'package:admin/CustomWidgets/JS_AppBar.dart';
import 'package:admin/CustomWidgets/job_ad.dart';
import 'package:admin/CustomWidgets/txtfeilds.dart';
import 'package:flutter/material.dart';

import '../Variables.dart';

class ViewAds extends StatefulWidget {
  const ViewAds({Key? key}) : super(key: key);

  @override
  _ViewAdsState createState() => _ViewAdsState();
}

class _ViewAdsState extends State<ViewAds> {
  late Admin admin;
  late List<JobAd> jobAds= [];

  searchJobAds()async{
    if (search.text.trim().length>0) {
      Navigator.pushNamed(context, "/Spinner");
      var res = await admin.searchJobAds(context,search.text);
      if(res is bool) return;
      if((res is List<JobAd>)) jobAds=res;
      else jobAds.clear();
      Navigator.pop(context);
      setState(() {});
      print("?N--------------------------------------------------/n\n\n\n${jobAds.toString()}");
    }
  }
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map;
    admin =  m1['admin'];
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
        child:Column(
            children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: 290,
                child: JsTextFeildIconed(
                  "html, css, Job for Junior Developer ",
                  search,
                  Icon(Icons.search, color: colorThird_G),
                  0.0,
                  0.0,
                  0.0,
                  20.0,
                  "Enter Titles or skills (comma\n separated)")),
              SizedBox(
                width: 60,
                height: 60,
                child: FlatButton(
                onPressed: () {
                searchJobAds();
              },
                child: Icon(Icons.search),
                color: colorThird_G,
            ),
          )
        ]),
              Column(children: jobAds.isNotEmpty? jobAds.map((e) => JobADAdminView(e, admin)).toList():[Padding(padding: EdgeInsets.only(top:100),child:Text("None found"))],),

            ])
        ,),
    );
  }
}