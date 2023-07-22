import 'package:mysql1/mysql1.dart';

import './MySQL.dart';

 class Address{
   int _AddressID=0;
   String _City="";
   String _Street="";
   String _HouseNumber="";
   int _postelCode=0;

   Address();

  Address.name(this._City, this._Street, this._HouseNumber,
      this._postelCode);

  static Future<dynamic> getAddress(AddressID,context)async{
    var results = await MySQL.query("Select * from sql6459853.Address where AddressID = $AddressID",context);
    if(results is bool) return false;
    if(results.isEmpty) return false;
    Address address=Address();
    for(var row in results) {
      address.AddressID=row[0];
      address.City=row[1];
      address.Street=row[2];
      address.HouseNumber=row[3];
      address.postelCode=row[4];
    }
    return address;
  }


  int get AddressID => _AddressID;

  set AddressID(int value) {
    _AddressID = value;
  }

  String get City => _City;

  int get postelCode => _postelCode;

  set postelCode(int value) {
    _postelCode = value;
  }

  String get HouseNumber => _HouseNumber;

  set HouseNumber(String value) {
    _HouseNumber = value;
  }

  String get Street => _Street;

  set Street(String value) {
    _Street = value;
  }

  set City(String value) {
    _City = value;
  }


}