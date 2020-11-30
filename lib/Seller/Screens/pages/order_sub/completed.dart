import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/order_format.dart';

class OrderCompleted extends StatefulWidget {
  OrderCompleted({Key key}) : super(key: key);

  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
          title: Text(
            "Completed Orders",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(child: orderTile("completed", context)));
  }
}
