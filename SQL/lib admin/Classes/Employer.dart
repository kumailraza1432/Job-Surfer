import 'MySQL.dart';
import "User.dart";

class Employer extends User {
  List<String> _ExperienceOfFeild = [];
  List<String> _ExperienceInFeild = [];
  List<String> _Skills = [];

  Employer.one(int CNIC, String Name, String UserName, String Address,
      String DateOfBirth, String ContactNumber)
      : super.one(CNIC, Name, UserName, Address, DateOfBirth, ContactNumber);

  Employer() : super();

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
}
