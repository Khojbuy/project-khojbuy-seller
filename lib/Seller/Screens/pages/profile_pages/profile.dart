import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:khojbuy/Seller/Screens/pages/profile_pages/picture_selection.dart';
import 'package:khojbuy/Seller/Screens/pages/profile_pages/profile_form.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';

import 'package:khojbuy/Seller/Services/navigator_bloc.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');
final Reference reference = FirebaseStorage.instance.ref();
final snackbar = SnackBar(
    content: Text(
        "Profile Updated ! Changes might take some time to reflect \n Restart the app in case you dont see the changes"));

class ProfilePage extends StatefulWidget with NavigationStates {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, function) {
      return Scaffold(
          body: WillPopScope(
        onWillPop: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        },
        child: FutureBuilder(
          future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Check your Internet Connection",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              String imgURL = data["PhotoURL"];

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (imgURL == "url")
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 80,
                                  child: Image.asset(
                                    "assets/images/shop.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 20.0),
                                height: 200,
                                width: 200,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.0),
                                    child: PinchZoom(
                                      maxScale: 3.5,
                                      resetDuration:
                                          Duration(microseconds: 100),
                                      zoomedBackgroundColor:
                                          Colors.black.withOpacity(0.5),
                                      image: Image.network(
                                        imgURL,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ),
                        FlatButton(
                            textColor: Colors.blueAccent,
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PictureSelection(
                                        data["ShopName"].toString())),
                              );
                            },
                            child: Text(
                              "Change Photo",
                            )),
                        Text(
                          "The changes will be visible after you SAVE them",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            data["ShopName"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                                color: Color.fromRGBO(84, 176, 243, 1),
                                fontSize: 32,
                                letterSpacing: 2.5),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Shop Category : " + data["Category"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(84, 176, 243, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 200,
                          child: Divider(
                            color: Colors.white10,
                          ),
                        ),
                        ProfileForm(data),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ));
    });
  }
}
