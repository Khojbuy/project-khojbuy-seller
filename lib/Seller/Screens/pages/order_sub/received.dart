import 'package:flutter/material.dart';

class OrderReceived extends StatefulWidget {
  @override
  _OrderReceivedState createState() => _OrderReceivedState();
}

class _OrderReceivedState extends State<OrderReceived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY Orders Recieved",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
