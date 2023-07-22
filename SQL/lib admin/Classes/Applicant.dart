import 'MySQL.dart';
import "User.dart";

class Applicant extends User {
  List<String> _ExperienceOfFeild = [];
  List<String> _ExperienceInFeild = [];
  List<String> _Skills = [];

  Applicant.one(int CNIC, String Name, String UserName, String Address,
      String DateOfBirth, String ContactNumber)
      : super.one(CNIC, Name, UserName, Address, DateOfBirth, ContactNumber);

  Applicant() : super();

  List<String> get ExperienceOfFeild => _ExperienceOfFeild;

  List<String> get Skills => _Skills;

  set Skills(List<String> value) {
    _Skills = value;
  }

  set ExperienceOfFeild(List<String> value) {
    _ExperienceOfFeild = value;
  }

  List<String> get ExperienceInFeild => _ExperienceInFeild;

  set ExperienceInFeild(List<String> value) {
    _ExperienceInFeild = value;
  }
  // This method retrieves the skills, of the applicant has, from the database;
  // and stored them in the object
  Future<void> getSkills(context) async {
    if (Skills.length > 0) Skills.clear();
    var rows = await MySQL.query(
        "Select SkillName from `sql6459853`.`Skills_has_Applicant` natural join Skills where cnic = $CNIC;",context);
    for (var row in rows) Skills.add(row[0]);
  }
}
