import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/modelcard.dart';
import 'package:khojbuy/Seller/Screens/pages/orders.dart';
import 'package:khojbuy/Seller/Screens/pages/requests.dart';
import 'package:khojbuy/Seller/Screens/widgets/ordercard.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class DashBoardPage extends StatefulWidget with NavigationStates {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        cardPlate(cardSet[0], context, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyOrders()),
          );
        }),
        cardPlate(cardSet[1], context, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyRequests()),
          );
        })
      ],
    ));
  }
}
