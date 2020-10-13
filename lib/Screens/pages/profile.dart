import 'package:flutter/material.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';

class ProfilePage extends StatefulWidget with NavigationStates {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "PROFILE",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
