import 'package:flutter/material.dart';
import 'package:khojbuy/Screens/pages/dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Screens/sidebar/sidebar.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';

class HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigatorBloc>(
        create: (context) => NavigatorBloc(DashBoardPage()),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigatorBloc, NavigationStates>(
              builder: (context, NavigationStates) {
                return NavigationStates as Widget;
              },
            ),
            Sidebar()
          ],
        ),
      ),
    );
  }
}
