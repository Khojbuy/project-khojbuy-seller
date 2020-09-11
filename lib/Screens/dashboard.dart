import 'package:flutter/material.dart';
import 'package:khojbuy/Services/authservice.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
            child: Text("SIGNOUT"),
            onPressed: () {
              AuthService().signOut(context);
            }),
      ),
    );
  }
}
