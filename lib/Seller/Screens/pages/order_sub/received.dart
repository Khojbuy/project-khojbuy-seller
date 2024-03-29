import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/order_format.dart';

class OrderReceived extends StatefulWidget {
  @override
  _OrderReceivedState createState() => _OrderReceivedState();
}

class _OrderReceivedState extends State<OrderReceived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          title: Text(
            "Received Orders",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(child: orderTile("received", context)));
  }
}
