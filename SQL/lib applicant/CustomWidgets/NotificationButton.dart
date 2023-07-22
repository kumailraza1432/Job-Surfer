import '../Classes/MySQL.dart';
import '../Classes/Notifications.dart';
import '../Variables.dart';
import 'package:flutter/material.dart';

class NotificationButton extends StatefulWidget {

  NotificationButton({Key? key}) : super(key: key);

  NotificationButtonState btn = NotificationButtonState();
  @override
  NotificationButtonState createState() => this.btn;
}

class NotificationButtonState extends State<NotificationButton> {
  bool notification=false;
  Icon icon = Icon(Icons.notifications_active_outlined,color: colorThird_G,);

// Icon icon =
  changeIcon(){
    if(!notification) {
      notification = true;
      icon = Icon(Icons.notifications_active_outlined,color: colorThird_G,);
    }
    else {
      notification = false;
      icon = Icon(Icons.notifications,color: Colors.white);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return IconButton(onPressed: ()async{
      Navigator.pushNamed(context, "/Spinner");
      if ((await Notifications.getNotifications(context)) is bool) return;
      var result =await  MySQL.query("UPDATE `sql6459853`.`Notification` SET `Type` = 'Viewed' WHERE (`Type` = 'Not Viewed') and GeneratedFor=${Notifications.GeneratedForCNIC};", context);
      if(result is bool) return;
      Navigator.pop(context);
      Navigator.pushNamed(context, "/NotificationScreen");
    }, icon: icon);
  }
}
