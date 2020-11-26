import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/completed.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/received.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/to_confirm.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/to_pack.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
          title: Text(
            "ORDERS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderReceived()),
                    );
                  },
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color.fromRGBO(41, 74, 171, 0.98),
                    child: Container(
                      height: MediaQuery.of(context).size.longestSide * 0.1,
                      child: Center(
                        child: Text(
                          'RECEIVED',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderToConfirm()),
                    );
                  },
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color.fromRGBO(41, 74, 171, 0.98),
                    child: Container(
                      height: MediaQuery.of(context).size.longestSide * 0.1,
                      child: Center(
                        child: Text(
                          'TO CONFIRM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderToPack()),
                    );
                  },
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color.fromRGBO(41, 74, 171, 0.98),
                    child: Container(
                      height: MediaQuery.of(context).size.longestSide * 0.1,
                      child: Center(
                        child: Text(
                          'TO PACK',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderCompleted()),
                    );
                  },
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color.fromRGBO(41, 74, 171, 0.98),
                    child: Container(
                      height: MediaQuery.of(context).size.longestSide * 0.1,
                      child: Center(
                        child: Text(
                          'COMPLETED',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ));
  }
}
