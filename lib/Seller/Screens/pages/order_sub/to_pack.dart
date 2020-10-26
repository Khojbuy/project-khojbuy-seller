import 'package:flutter/material.dart';

class OrderToPack extends StatefulWidget {
  @override
  _OrderToPackState createState() => _OrderToPackState();
}

class _OrderToPackState extends State<OrderToPack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY Order to Pack",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
