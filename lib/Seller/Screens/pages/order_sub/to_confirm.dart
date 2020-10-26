import 'package:flutter/material.dart';

class OrderToConfirm extends StatefulWidget {
  @override
  _OrderToConfirmState createState() => _OrderToConfirmState();
}

class _OrderToConfirmState extends State<OrderToConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MY order to confirm",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
