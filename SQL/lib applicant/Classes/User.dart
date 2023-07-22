/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of User class
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case alphabet
///     -- Global variables should end with _G

import "Address.dart";


class User {
   int _CNIC=0000;
   String _Name="";
   String _UserName="";
   late var _Address ;
   String _DateOfBirth="";
   String _ContactNumber="";

  User();

  User.one(this._CNIC, this._Name, this._UserName, this._Address,
      this._DateOfBirth, this._ContactNumber);

  @override
  String toString() {
    return 'User{_CNIC: $_CNIC, _Name: $_Name, _userName: $_UserName, _Address: $_Address, _DateOfBirth: $_DateOfBirth, _ContactNumber: $_ContactNumber}';
  }

  //this method searches the given credentials in the database, if user authenticates, it
  //stores it in the objects and return true; else it return false/
  // Future<bool> login(String CNIC,context) async {
  //   Results results = await MySQL.query("SELECT * sql6459853.User where CNIC='$CNIC''",context);
  //   if(results.length<0) return false;
  //   for (var row in results) {
  //     _CNIC = row[0];
  //     _Name = row[1];
  //     _UserName = row[5];
  //     _DateOfBirth = row[2];
  //    // _Address = row[4];
  //     _ContactNumber = row[3];}
  //   return true;
  // }

  String get ContactNumber => _ContactNumber;

  set ContactNumber(String value) {
    _ContactNumber = value;
  }

  String get DateOfBirth => _DateOfBirth;

  set DateOfBirth(String value) {
    _DateOfBirth = value;
  }

  get Address => _Address;

  set Address(value) {
    _Address = value;
  }

  String get userName => _UserName;

  set userName(String value) {
    _UserName = value;
  }

  String get Name => _Name;

  set Name(String value) {
    _Name = value;
  }

  String get UserName => _UserName;

  set UserName(String value) {
    _UserName = value;
  }

  int get CNIC => _CNIC;

  set CNIC(int value) {
    _CNIC = value;
  }
}
