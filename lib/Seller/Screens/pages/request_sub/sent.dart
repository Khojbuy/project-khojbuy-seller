import 'package:flutter/material.dart';

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
          "Received Orders",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text(
          "MY REQUESTS SENT",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
