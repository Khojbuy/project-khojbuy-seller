import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/order_sub/orders.dart';
import 'package:khojbuy/Seller/Screens/pages/request_sub/requests.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String fcm;
getToken() async {
  fcm = await _firebaseMessaging.getToken();
  FirebaseFirestore.instance
      .collection('SellerData')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .update({'FCM': fcm});
}

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
                if (data['FCM'] == '') {
                  getToken();
                }
                //_firebaseMessaging.onTokenRefresh.listen(getToken());
                if (data["display"] == true) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        cardTemp("ORDERS", "assets/images/shopping-list.png",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyOrders()),
                          );
                        }, context),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.longestSide * 0.05,
                        ),
                        cardTemp("REQUESTS", "assets/images/searching.png", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyRequests()),
                          );
                        }, context),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cardSmall(() {}, "Advertisement",
                                "assets/images/ad.png", context),
                            cardSmall(() {}, "Product List",
                                "assets/images/list.png", context),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Text(
                      "You have not been authenticated yet. Keep Paitence. We will contact you within 24 hours.",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    ));
  }
}

cardSmall(
    Function onTapCall, String name, String assestname, BuildContext context) {
  return InkWell(
    onTap: onTapCall,
    child: Card(
      color: Color.fromRGBO(84, 176, 243, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 8.0,
      // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      child: Stack(
        fit: StackFit.loose,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              height: MediaQuery.of(context).size.longestSide * 0.16,
              width: MediaQuery.of(context).size.longestSide * 0.17,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.longestSide * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      assestname,
                      width: MediaQuery.of(context).size.shortestSide * 0.15,
                      height: MediaQuery.of(context).size.shortestSide * 0.15,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomRight,
                      colorBlendMode: BlendMode.color,
                    ),
                    ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstOut,
                      child: Container(
                        color: Colors.blue,
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

cardTemp(String name, String image, Function onTapCall, BuildContext context) {
  return InkWell(
    onTap: onTapCall,
    child: Card(
      color: Color.fromRGBO(84, 176, 243, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Stack(
        fit: StackFit.loose,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              height: MediaQuery.of(context).size.longestSide * 0.15,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: ListTile(
                      title: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(
                          color: Colors.blue,
                          padding: EdgeInsets.only(left: 18.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            bottom: 8.0,
            right: 8.0,
            child: Image.asset(
              image,
              width: MediaQuery.of(context).size.shortestSide * 0.45,
              height: MediaQuery.of(context).size.shortestSide * 0.45,
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
              colorBlendMode: BlendMode.color,
            ),
          ),
        ],
      ),
    ),
  );
}
