import '../Classes/Address.dart';
import '../CustomWidgets/TwoValuesText.dart';
import 'package:flutter/material.dart';
import '';


class AddressWidget extends StatefulWidget {
  Address address;
  AddressWidget(this.address,{Key? key}) : super(key: key);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      Key1("City", 17.0),
      Value(widget.address.City, 15.0),
      Key1("Street", 17.0),
      Value(widget.address.Street, 15.0),
      Key1("House Number", 17.0),
      Value(widget.address.HouseNumber, 15.0),
      Key1("postel Code", 17.0),
      Value(widget.address.postelCode, 15.0),

    ],);
  }
}
