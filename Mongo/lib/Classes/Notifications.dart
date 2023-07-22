import 'dart:io';

import './Notification.dart';
import 'MySQL.dart';

class Notifications{
  static late int GeneratedForCNIC;
  static  List<NotificationCustom> NotificationsList=[];
  static late Function? changeIcon=null;
  static Future<dynamic> getNotifications(context)async{

        print(GeneratedForCNIC);

        var results = await MySQL.query("select forName,year,Month,day,title,GeneratedBy,type,byName from (SELECT Name as forName,year,month,day,title,GeneratedBy,type,NotificationID from sql6459853.User natural join sql6459853.Notification where generatedFor=CNIC and GeneratedFor=$GeneratedForCNIC) as a natural join (SELECT Name as byName,year,month,day,title,GeneratedBy,type,NotificationID from sql6459853.User natural join sql6459853.Notification where generatedby=CNIC and GeneratedFor=$GeneratedForCNIC) as b", context);
        print(results);
          if(results is bool) return false;
            NotificationsList=[];
            for (var row in results)
              NotificationsList.add(NotificationCustom.one(0,
                  DateTime(row[1], row[2], row[3]), row[4], row[6], row[7]));
            NotificationsList= NotificationsList.reversed.toList();
        //sleep(Duration(seconds: 3));

    }

}
