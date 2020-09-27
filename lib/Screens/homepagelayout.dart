import 'package:flutter/material.dart';
import 'package:khojbuy/Screens/pages/dashboard.dart';
import 'package:khojbuy/Screens/sidebar/sidebar.dart';

class HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[DashBoardPage(), Sidebar()],
    ));
  }
}
