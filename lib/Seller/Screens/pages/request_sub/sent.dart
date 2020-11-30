import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/request_format.dart';

class RequestSent extends StatefulWidget {
  @override
  _RequestSentState createState() => _RequestSentState();
}

class _RequestSentState extends State<RequestSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
          title: Text(
            "Responded Requests",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: requestTile("responded", context),
        ));
  }
}
