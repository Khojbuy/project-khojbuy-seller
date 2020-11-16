import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Seller/Screens/homepage_seller.dart';
import 'package:khojbuy/Seller/Screens/pages/dashboard.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

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
        child: HomePageSeller(),
      ),
    );
  }
}
