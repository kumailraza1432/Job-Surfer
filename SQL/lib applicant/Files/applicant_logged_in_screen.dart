import 'package:applicant/Classes/Applicant.dart';
import 'package:applicant/Classes/JobAd.dart';
import 'package:applicant/CustomWidgets/JS_AppBar.dart';
import 'package:applicant/CustomWidgets/job_ad.dart';
import 'package:applicant/CustomWidgets/txtfeilds.dart';
import 'package:applicant/Variables.dart';
import 'package:flutter/material.dart';

class ApplicantLoggedInScreen extends StatefulWidget {
  const ApplicantLoggedInScreen({Key? key}) : super(key: key);

  @override
  _ApplicantLoggedInScreenState createState() => _ApplicantLoggedInScreenState();
}

class _ApplicantLoggedInScreenState extends State<ApplicantLoggedInScreen> {
  late Applicant applicant;
  late List<JobAd> jobAds= [];

  searchJobAds()async{
    if (search.text.trim().length>0) {
      searched=true;
      Navigator.pushNamed(context, "/Spinner");
      var res = await applicant.searchJobAds(context,search.text);
      if(res is bool) return;
      if((res is List<JobAd>)) jobAds=res;
      else jobAds.clear();
      Navigator.pop(context);
      setState(() {});
      print("?N--------------------------------------------------/n\n\n\n${jobAds.toString()}");
    }
  }
  TextEditingController search = TextEditingController();
  bool searched=false;
  bool droppedUp=false;
  late List<Widget>  floatingActionButtons=[FloatingActionButton(backgroundColor: colorThird_G,onPressed: (){swapButton();},child: Icon(Icons.arrow_drop_up_outlined),)];
  void swapButton(){
    if(!droppedUp){droppedUp=true;
    floatingActionButtons=[
      Padding(padding: EdgeInsets.only(bottom: 5.0),child:FloatingActionButton(backgroundColor: colorThird_G,onPressed: (){Navigator.pushNamed(context, "/ApplicantProfile",arguments: {"applicant":applicant});},child: Icon(Icons.person),)),
      Padding(padding: EdgeInsets.only(bottom: 5.0),child:FloatingActionButton(backgroundColor: colorThird_G,onPressed: (){Navigator.pushNamed(context, "/ApplcationViewScreen",arguments: {"applicant":applicant});},child: Icon(Icons.rate_review_rounded),)),
      Padding(padding: EdgeInsets.only(bottom: 5.0),child:FloatingActionButton(backgroundColor: colorThird_G,onPressed: (){Navigator.popAndPushNamed(context, "/LoginPage");},child: Icon(Icons.logout),)),
      FloatingActionButton(backgroundColor: colorThird_G,onPressed: (){swapButton();},child: Icon(Icons.arrow_drop_down_outlined),),
    ];}
    else {
      floatingActionButtons = [
        FloatingActionButton(backgroundColor: colorThird_G,
          onPressed: () {
            swapButton();
          },
          child: Icon(Icons.arrow_drop_up_outlined),
        )
      ];
      droppedUp=false;
    }
    setState((){});

  }
  @override
  Widget build(BuildContext context) {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map;
    applicant =  m1['applicant'];
    return Scaffold(appBar: JS_AppBarNotifictaion(),
      body: SingleChildScrollView(
        child:Column(
          children: [JS_SearchBar("css,html, job for an intern", search, Icon(Icons.search), searchJobAds,radius: BorderRadius.circular(100.0),description: "Skills, tittle( comma separated) "),
          searched==false?
          Column(children:[
            const Padding(padding:EdgeInsets.only(top:50.0,),child:Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 270,
                width: 270,
              ))),Text("Begain the search for success!",style: TextStyle(color:colorThird_G),)]):
          Column(children: jobAds.isNotEmpty? jobAds.map((e) => JobADApplicantView(e, applicant)).toList():[Padding(padding: EdgeInsets.only(top:100),child:Text("None found"))],),

            ])
        ,),
        
      floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end,children:floatingActionButtons),
    );
  }
}
