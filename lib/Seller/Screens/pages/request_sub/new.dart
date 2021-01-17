import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/request_format.dart';

class RequestNew extends StatefulWidget {
  @override
  _RequestNewState createState() => _RequestNewState();
}

class _RequestNewState extends State<RequestNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          title: Text(
            "New Requests",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: requestTile("new", context),
        ));
  }
}
