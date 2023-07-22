import 'package:applicant/Classes/Applicant.dart';
import 'package:applicant/Classes/JobAd.dart';
import 'package:applicant/CustomWidgets/TwoValuesText.dart';
import 'package:applicant/Variables.dart';
import 'package:flutter/material.dart';

class JobADApplicantView extends StatelessWidget {
  JobADApplicantView(this.j,this.applicant,{Key? key}) : super(key: key);
  late JobAd j;
  late Applicant applicant;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/JobAdsDetails',
                              arguments: {
                                "ad": j,
                                "applicant": applicant
                              });
                        },
                        child: Text("Details"),
                        color: colorThird_G,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "Posted By  : ",
                          style: TextStyle(fontSize: 17, color: colorThird_G),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: LimitedBox(
                            maxWidth: 200.0,
                            child: Text(
                              j.Author,
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.left,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "Job Title  : ",
                          style: TextStyle(fontSize: 17, color: colorThird_G),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: LimitedBox(
                            maxWidth: 200.0,
                            child: Text(
                              j.Title,
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.left,
                            )),
                      ),
                      Text(
                        "Posted on  : ",
                        style: TextStyle(fontSize: 17, color: colorThird_G),
                      ),
                      ValueWithFormat(j.PostedDate,15.0,200.0,0.0,"(yyyy-mm-dd)",30.0),
                      Text(
                        "Valid Till : ",
                        style: TextStyle(fontSize: 17, color: colorThird_G),
                      ),
                      ValueWithFormat(j.ExpireDate,15.0,200.0,0.0,"(yyyy-mm-dd)",30.0),
                      Text(
                        "Skills Required : ",
                        style: TextStyle(fontSize: 17, color: colorThird_G),
                      ),
                      Value(j.SkillsRequired.toString().substring(1,j.SkillsRequired.toString().length-1),15.0,200.0,0.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
    );

  }
}
