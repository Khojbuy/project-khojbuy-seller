import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/orders.dart';
import 'package:khojbuy/Seller/Screens/pages/requests.dart';
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
        Card(
          color: Color.fromRGBO(41, 74, 171, 0.98),
          child: GestureDetector(
            child: Center(
              child: Text('ORDERS'),
              widthFactor: 50,
              heightFactor: 50,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrders()),
              );
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.longestSide * 0.05,
        ),
        Card(
          color: Color.fromRGBO(41, 74, 171, 0.98),
          child: GestureDetector(
            child: Center(
              child: Text('REQUESTS'),
              widthFactor: 50,
              heightFactor: 50,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRequests()),
              );
            },
          ),
        )
      ],
    ));
  }
}
