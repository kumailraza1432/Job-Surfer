/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 29,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a functions, Key1,Value and DoubleListValue , that returns a custom Text Widgets
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case aplhabet
///     -- Global variables should end with _G
import 'package:flutter/material.dart';
import '../Variables.dart';

Padding Key1(text1, size, [topPadding = 15.0, color = Colors.teal]) {
  text1 += " : ";
  size = size + 0.0;
  topPadding += 0.0;
  return Padding(
    padding: EdgeInsets.only(left: 20, top: topPadding),
    child: Text(
      text1,
      style: TextStyle(fontSize: size, color: color),
    ),
  );
}
Padding Key1WithColor(text1, size, {topPadding = 15.0, fg = Colors.teal}) {
  text1 += " : ";
  size = size + 0.0;
  topPadding += 0.0;
  return Padding(
    padding: EdgeInsets.only(left: 20, top: topPadding),
    child: Text(
      text1,
      style: TextStyle(fontSize: size, color: fg),
    ),
  );
}


dynamic Value(dynamic text2, size, [boxWidth = 200.0, topPadding = 15.0]) {
  text2 = text2.toString();
  size += 0.0;
  return LimitedBox(
    maxWidth: boxWidth,
    child: Padding(
        padding: EdgeInsets.only(left: 60, top: topPadding),
        child: Text(
          "" + text2,
          style: TextStyle(fontSize: size), textAlign: TextAlign.left,
          //overflow: TextOverflow.ellipsis,
        )),
  );
}

dynamic ValueWithClr(dynamic text2, size, {boxWidth = 200.0, topPadding = 15.0,fg=Colors.white}) {
  text2 = text2.toString();
  size += 0.0;
  return LimitedBox(
    maxWidth: boxWidth,
    child: Padding(
        padding: EdgeInsets.only(left: 60, top: topPadding),
        child: Text(
          "" + text2,
          style: TextStyle(fontSize: size,color: fg), textAlign: TextAlign.left,
          //overflow: TextOverflow.ellipsis,
        )),
  );
}

dynamic ValueWithFormat(dynamic text2, size, [boxWidth = 200.0, topPadding = 15.0,format="",leftPadding=60.0]) {
  text2 = text2.toString();
  size += 0.0;
  return LimitedBox(
    maxWidth: boxWidth,
    child: Padding(
        padding: EdgeInsets.only(left: leftPadding, top: topPadding),
        child:Row (children :[Text(
          "" + text2,
          style: TextStyle(fontSize: size), textAlign: TextAlign.left,
          //overflow: TextOverflow.ellipsis,
        ),Padding(
          padding: const EdgeInsets.only(top:5,left:10),
          child: Text(
            format,
            style: TextStyle(fontSize: 9,color: Colors.grey), textAlign: TextAlign.left,

          ),
        )])),
  );
}

dynamic ValueWithFormatClr(dynamic text2, size, {boxWidth = 200.0, topPadding = 15.0, format = "", leftPadding = 60.0,fg=Colors.white,formatClr=Colors.grey}) {
  text2 = text2.toString();
  size += 0.0;
  return LimitedBox(
    maxWidth: boxWidth,
    child: Padding(
        padding: EdgeInsets.only(left: leftPadding, top: topPadding),
        child:Row (children :[Text(
          "" + text2,
          style: TextStyle(fontSize: size,color: fg), textAlign: TextAlign.left,
          //overflow: TextOverflow.ellipsis,
        ),Padding(
          padding: const EdgeInsets.only(top:5,left:10),
          child: Text(
            format,
            style: TextStyle(fontSize: 9,color: formatClr), textAlign: TextAlign.left,

          ),
        )])),
  );
}

dynamic DoubleListValues(Map<String,String> value) {
  if (value.length < 1) return Value("None", 15.0);
  List<Widget> wList = [];
  value.forEach((key, value) {
    wList.add(Key1(key, 15.0));
    wList.add(Value(value, 15.0));
    });

  return Padding(
    padding: EdgeInsets.only(left: 15),
    child: Column(children: wList),
  );
}
