import '../Variables.dart';
import './TwoValuesText.dart';
import 'package:flutter/material.dart';
import '../Classes/Notification.dart';
class NotificationView extends StatefulWidget {
  NotificationView(this.notification,{Key? key}) : super(key: key);
  late NotificationCustom notification;
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late Color? bg,fg;
  @override
  Widget build(BuildContext context) {
    if(widget.notification.Type == "Viewed") {bg=colorThird_G;fg=Colors.white;}
    else {fg=Colors.white;bg=Colors.white;}
    return  Container(
      child: (Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueWithClr("${widget.notification.by} ${widget.notification.Title}  ", 17,fg: fg,),
          ValueWithFormatClr("${widget.notification.date.toString().substring(0,11)}", 15,format: "yyyy-mm-dd",fg: fg,formatClr: widget.notification.Type!="Viewed"?Colors.white:Colors.grey)
        ],
      )),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),color:  widget.notification.Type!="Viewed"?colorThird_G:null
      ),
     margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
    );
  }
}
