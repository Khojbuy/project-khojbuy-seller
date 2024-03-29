import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/completed.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/received.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/to_pack.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 0.98),
          title: Text(
            "ORDERS",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'OpenSans',
            ),
          ),
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
                orderCard("ORDERS RECIEVED", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderReceived()),
                  );
                }, context),
                orderCard("ORDERS TO PACK", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderToPack()),
                  );
                }, context),
                orderCard("ORDERS COMPLETED", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderCompleted()),
                  );
                }, context)
              ],
            ),
          ),
        ));
  }
}

Column orderCard(String name, Function ontap, BuildContext context) {
  return Column(
    children: [
      InkWell(
        onTap: ontap,
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color.fromRGBO(84, 176, 243, 0.98),
          child: Container(
            height: MediaQuery.of(context).size.longestSide * 0.1,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
    ],
  );
}
