import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY ORDERS",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
