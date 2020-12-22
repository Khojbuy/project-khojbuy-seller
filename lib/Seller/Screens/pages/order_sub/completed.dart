import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/order_format.dart';

class OrderCompleted extends StatefulWidget {
  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          title: Text(
            "Completed Orders",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(child: orderTile("completed", context)));
  }
}
