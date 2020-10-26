import 'package:flutter/material.dart';

class RequestNew extends StatefulWidget {
  @override
  _RequestNewState createState() => _RequestNewState();
}

class _RequestNewState extends State<RequestNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY REQUESTS NEW",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
