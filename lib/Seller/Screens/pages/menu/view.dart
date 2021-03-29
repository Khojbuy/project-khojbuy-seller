import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/menu/edit.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Here is your catalouge',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                            FloatingActionButton(
                                child: Icon(
                                  Icons.edit,
                                  size: 28,
                                ),
                                tooltip: 'Edit',
                                backgroundColor:
                                    Color.fromRGBO(84, 176, 243, 1),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuEdit(snapshot.data['Menu'])),
                                  );
                                })
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data['Menu'].length,
                            itemBuilder: (context, index) {
                              return Expanded(
                                child: ListTile(
                                  dense: true,
                                  enabled: true,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          snapshot.data['Menu'][index]
                                              ['ItemName'],
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '₹ ' +
                                              snapshot.data['Menu'][index]
                                                  ['Price'],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'OpenSans',
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          snapshot.data['Menu'][index]
                                              ['Detail'],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'OpenSans',
                                              fontSize: 12),
                                        ),
                                      ),
                                      (snapshot.data['Menu'][index]['Image'] ==
                                              '')
                                          ? Container()
                                          : Expanded(
                                              child: Container(
                                                  child: PinchZoom(
                                                maxScale: 3.5,
                                                resetDuration:
                                                    Duration(microseconds: 100),
                                                zoomedBackgroundColor: Colors
                                                    .black
                                                    .withOpacity(0.5),
                                                image: CachedNetworkImage(
                                                  imageUrl:
                                                      snapshot.data['Menu']
                                                          [index]['Image'],
                                                  fadeInCurve: Curves.easeIn,
                                                  fit: BoxFit.cover,
                                                  fadeOutDuration: Duration(
                                                      microseconds: 100),
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      Container(
                                                          height: 10,
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress)),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )),
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
