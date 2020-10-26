import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/request_sub/new.dart';
import 'package:khojbuy/Seller/Screens/pages/request_sub/sent.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
          title: Text("ORDERS"),
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
                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromRGBO(41, 74, 171, 0.98),
                  child: InkWell(
                    child: GestureDetector(
                      child: Container(
                        height: MediaQuery.of(context).size.longestSide * 0.1,
                        child: Center(
                          child: Text(
                            'NEW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RequestNew()),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color.fromRGBO(41, 74, 171, 0.98),
                  child: InkWell(
                    child: GestureDetector(
                      child: Container(
                        height: MediaQuery.of(context).size.longestSide * 0.1,
                        child: Center(
                          child: Text(
                            'SENT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestSent()),
                        );
                      },
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