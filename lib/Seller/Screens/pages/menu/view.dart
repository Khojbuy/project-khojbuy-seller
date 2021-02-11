import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/menu/edit.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class ShopMenu extends StatefulWidget with NavigationStates {
  @override
  _ShopMenuState createState() => _ShopMenuState();
}

class _ShopMenuState extends State<ShopMenu> {
  final menukey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: menukey,
        body: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()));
          },
          child: Container(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('SellerData')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text(
                      'Please check your internet connection',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 24,
                          color: Colors.black87),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data['Menu'].toString() == '[]') {
                  return Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              'You can use this feature to show your products to your customers. This can be a great marketing tool.\n',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.black87),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Make Your Catalouge',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MenuEdit(snapshot.data['Menu'])),
                                    );
                                  },
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    color: Colors.blue))
                          ]),
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text('HERE IS YOUR CATALOUGE'),
                            ),
                            RaisedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuEdit(snapshot.data.documents)),
                                  );
                                },
                                icon: Icon(Icons.edit_attributes_rounded),
                                label: Text('Edit'))
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Text(snapshot.data.documents[index]['Item']
                                      .toString()),
                                  Text(snapshot.data.documents[index]['Detail']
                                      .toString()),
                                  Text(snapshot.data.documents[index]['Price']
                                      .toString())
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                );
              },
            ),

            /*  
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('SellerData')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Menu')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text(
                      'Please check your internet connection',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 24,
                          color: Colors.black87),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.documents.toString() == '[]') {
                  return Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              'You can use this feature to show your products to your customers. This can be a great marketing tool.\n',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.black87),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Make Your Catalouge',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuEdit(
                                              snapshot.data.documents)),
                                    );
                                  },
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    color: Colors.blue))
                          ]),
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text('HERE IS YOUR CATALOUGE'),
                            ),
                            RaisedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuEdit(snapshot.data.documents)),
                                  );
                                },
                                icon: Icon(Icons.edit_attributes_rounded),
                                label: Text('Edit'))
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Text(snapshot.data.documents[index]['Item']
                                      .toString()),
                                  Text(snapshot.data.documents[index]['Detail']
                                      .toString()),
                                  Text(snapshot.data.documents[index]['Price']
                                      .toString())
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                );
              },
            ), */
          ),
        ));
  }
}
