import 'package:flutter/material.dart';

class OrderCompleted extends StatefulWidget {
  OrderCompleted({Key key}) : super(key: key);

  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY Completed Orders",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
