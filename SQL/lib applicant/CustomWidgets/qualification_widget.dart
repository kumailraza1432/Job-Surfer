import '../CustomWidgets/TwoValuesText.dart';
import 'package:flutter/material.dart';
import '../Classes/qualific.dart';

class QualificationWidget extends StatelessWidget {
  QualificationWidget(this.qualifications,{Key? key}) : super(key: key);
  late List<Qualification_> qualifications;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: qualifications.map((e) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Key1("Institute", 17.0),
          Value(e.Institute, 15.0),
          Key1("Year From", 17.0),
          Value(e.YearFrom, 15.0),
          Key1("Year To", 17.0),
          Value(e.YearTo, 15.0),
          Key1("Type", 17.0),
          Value(e.Type, 15.0),
          Key1("Feild", 17.0),
          Value(e.Feild, 15.0),
          Divider(endIndent: 50,thickness: 3.0,),
        ],
      )).toList(),

    );
  }
}
