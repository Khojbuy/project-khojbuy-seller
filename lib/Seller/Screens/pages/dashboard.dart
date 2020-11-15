import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/orders.dart';
import 'package:khojbuy/Seller/Screens/pages/requests.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class DashBoardPage extends StatefulWidget with NavigationStates {
  final bool showDisplay;
  DashBoardPage(bool bool, {this.showDisplay});
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final bool showDisplay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: showDisplay
            ? Column(
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
                          height: MediaQuery.of(context).size.longestSide * 0.2,
                          child: Center(
                            child: Text(
                              'ORDERS',
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
                            MaterialPageRoute(builder: (context) => MyOrders()),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.longestSide * 0.05,
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
                          height: MediaQuery.of(context).size.longestSide * 0.2,
                          child: Center(
                            child: Text(
                              'REQUESTS',
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
                                builder: (context) => MyRequests()),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            : Container(
                child: Text(
                    "You have not been authenticated yet. Keep Paitence. We will contact you."),
              ),
      ),
    ));
  }
}
