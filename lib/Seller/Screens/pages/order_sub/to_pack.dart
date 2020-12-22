import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/order_format.dart';

class OrderToPack extends StatefulWidget {
  @override
  _OrderToPackState createState() => _OrderToPackState();
}

class _OrderToPackState extends State<OrderToPack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          title: Text(
            "Orders to Pack",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(child: orderTile("to pack", context)));
  }
}
