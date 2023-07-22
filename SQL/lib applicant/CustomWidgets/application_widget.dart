import 'package:applicant/Classes/Application.dart';
import 'package:applicant/Classes/JobAd.dart';
import 'package:flutter/material.dart';

import 'TwoValuesText.dart';

class ApplicationWidget extends StatefulWidget {
  ApplicationWidget(this.Author,this.Title,this.Status,this.EmployerNote,{Key? key}) : super(key: key);
  late String Author;
  late String Title;
  late String Status;
  late String EmployerNote;
  @override
  _ApplicationWidgetState createState() => _ApplicationWidgetState();
}

class _ApplicationWidgetState extends State<ApplicationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          SizedBox(width: 380.0,),
          Key1("Posted by", 17.0,0.0),
          Value(widget.Author, 15.0,200.0,0.0),
          Key1("Title", 17.0,0.0),
          Value(widget.Title, 15.0,200.0,0.0),
          Key1("Status", 17.0,0.0),
          Value(widget.Status, 15.0,200.0,0.0),
          Key1("Employe's Note", 17.0,0.0),
          Value(widget.EmployerNote, 15.0,200.0,0.0),
        ]
      )

      ,decoration: BoxDecoration(
      border: Border.all(width: 2, color: Colors.grey),
    ),
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),);
  }
}
