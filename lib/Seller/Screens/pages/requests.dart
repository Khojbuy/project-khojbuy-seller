import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/orders.dart';
import 'package:khojbuy/Seller/Screens/pages/request_sub/new.dart';
import 'package:khojbuy/Seller/Screens/pages/request_sub/sent.dart';

class MyRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 0.98),
          title: Text("REQUESTS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'OpenSans',
              )),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                orderCard("NEW REQUESTS", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestNew()),
                  );
                }, context),
                orderCard("RESPONDED REQUESTS", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestSent()),
                  );
                }, context)
              ],
            ),
          ),
        ));
  }
}
