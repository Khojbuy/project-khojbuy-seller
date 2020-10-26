import 'package:flutter/material.dart';

class RequestSent extends StatefulWidget {
  @override
  _RequestSentState createState() => _RequestSentState();
}

class _RequestSentState extends State<RequestSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY REQUESTS SENT",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
