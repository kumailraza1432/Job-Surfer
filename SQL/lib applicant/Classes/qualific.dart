
class Qualification_{late int _Qualification_ID;
late String _Institute;
late int _YearFrom;
late int _YearTo;
late String _Type;
late String _Feild;

Qualification_.one(this._Qualification_ID, this._Institute, this._YearFrom,
this._YearTo, this._Type, this._Feild);
Qualification_();
String get Feild => _Feild;

set Feild(String value) {
_Feild = value;
}

String get Type => _Type;

set Type(String value) {
_Type = value;
}

int get YearTo => _YearTo;

set YearTo(int value) {
_YearTo = value;
}

int get YearFrom => _YearFrom;

set YearFrom(int value) {
_YearFrom = value;
}

String get Institute => _Institute;

set Institute(String value) {
_Institute = value;
}

int get Qualification_ID => _Qualification_ID;

set Qualification_ID(int value) {
_Qualification_ID = value;
}}