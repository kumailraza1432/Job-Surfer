import 'package:admin/Classes/Admin.dart';
import 'package:admin/Classes/Applicant.dart';
import 'package:admin/CustomWidgets/txtfeilds.dart';
import 'package:flutter/material.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../Variables.dart';

class SearchApplicant extends StatefulWidget {
  const SearchApplicant({Key? key}) : super(key: key);

  @override
  _SearchApplicantState createState() => _SearchApplicantState();
}

class _SearchApplicantState extends State<SearchApplicant> {
  late Admin admin;

  List<Applicant> Applicants = [];
  var Loaded = true;
  TextEditingController Search = TextEditingController();
  String SearchResult = "Waiting for you to Search...";

  Future<void> SearchApplicants() async {
    setState(() {
      Loaded = false;
    });
    Applicants = await admin.searchApplicants(Search.text,context);
    if (Applicants.length < 1) SearchResult = "No user found";
    setState(() {
      Loaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map m1 =
        ModalRoute.of(context)?.settings.arguments as Map<String, Admin>;
    admin = m1["admin"];
    if (!Loaded)
      return spinner_G;
    else if (Applicants.length < 1)
      return Scaffold(
        appBar: JS_AppBar(),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    SizedBox(
                        width: 290,
                        child: JsTextFeildIconed(
                            " i.e. html, css, CNN, Paul ",
                            Search,
                            Icon(Icons.search, color: colorThird_G),
                            0.0,
                            0.0,
                            0.0,
                            20.0,
                            "Enter Usernames, name, Tags or skills (comma\n separated)")),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: FlatButton(
                        onPressed: () {
                          SearchApplicants();
                        },
                        child: Icon(Icons.search),
                        color: colorThird_G,
                      ),
                )
              ]),
            ),
            Center(child: Text(SearchResult))
          ],
        )),
      );
    else
      return Scaffold(
        appBar: JS_AppBar(),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child:
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: 290,
                    child: JsTextFeildIconed(
                        "Paul, Julian",
                        Search,
                        Icon(Icons.search, color: colorThird_G),
                        0.0,
                        0.0,
                        0.0,
                        20.0,
                        "Enter Usernames, name (comma\n separated)")),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {
                      SearchApplicants();
                    },
                    child: Icon(Icons.search),
                    color: colorThird_G,
                  ),
                )
              ]),
            ),
                Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: Applicants.map((applicant) => Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/dummyPFP.png'),
                                        radius: 50.0,
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                "/ApplicantProfileAtView",
                                                arguments: {
                                                  "applicant": applicant
                                                });
                                          },
                                          child: Text("view Profile"),
                                          color: colorThird_G)
                                    ]),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Key1("User Name", 17, 0.0),
                                    Value(applicant.UserName, 15, 250.0, 0.0),
                                    Key1("Name", 17, 0.0),
                                    Value(applicant.Name, 15, 250.0, 0.0),
                                    Key1("Skills", 17, 0.0),
                                    Value(
                                        applicant.Skills.toString().substring(
                                            1,
                                            applicant.Skills.toString().length -
                                                1),
                                        15,
                                        200.0,
                                        0.0),
                                  ],
                                )
                              ]),
                            ))))
                    .toList())
          ],
        )),
      );
  }
}
