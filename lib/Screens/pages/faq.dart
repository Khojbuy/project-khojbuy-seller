import 'package:flutter/material.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';

class Faq extends StatefulWidget with NavigationStates {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "FAQ",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
