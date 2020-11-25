import 'package:flutter/material.dart';

class OrderToConfirm extends StatefulWidget {
  @override
  _OrderToConfirmState createState() => _OrderToConfirmState();
}

class _OrderToConfirmState extends State<OrderToConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
        title: Text(
          "Received Orders",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text(
          "MY order to confirm",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
