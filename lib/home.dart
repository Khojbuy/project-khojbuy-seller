import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Screens/drawerlayout.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';
import 'Screens/pages/dashboard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<NavigatorBloc>(
        create: (context) => NavigatorBloc(DashBoardPage()),
        child: HomePageLayout(),
      ),
    );
  }
}
