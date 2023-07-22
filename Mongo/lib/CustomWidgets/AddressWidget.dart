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
      Key1("City", 20.0),
      Value(widget.address.City, 20.0),
      Key1("Street", 20.0),
      Value(widget.address.Street, 20.0),
      Key1("House Number", 20.0),
      Value(widget.address.HouseNumber, 20.0),
      Key1("postel Code", 20.0),
      Value(widget.address.postelCode, 20.0),

    ],);
  }
}
