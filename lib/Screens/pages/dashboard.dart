import 'package:flutter/material.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';

class DashBoardPage extends StatefulWidget with NavigationStates {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "DASHBOARD",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
