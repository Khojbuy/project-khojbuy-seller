import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/orders.dart';
import 'package:khojbuy/Seller/Screens/pages/requests.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');

class DashBoardPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: FutureBuilder(
            future: Future.delayed(Duration(microseconds: 1)).then((value) {
              return users.doc(FirebaseAuth.instance.currentUser.uid).get();
            }),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();

                if (data["display"] == true) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyOrders()),
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
                            height:
                                MediaQuery.of(context).size.longestSide * 0.2,
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
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.longestSide * 0.05,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyRequests()),
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
                            height:
                                MediaQuery.of(context).size.longestSide * 0.2,
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
                        ),
                      )
                    ],
                  );
                } else {
                  return Container(
                    child: Text(
                      "You have not been authenticated yet. Keep Paitence. We will contact you within 24 hours.",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    ));
  }
}
