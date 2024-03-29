import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            (imgURL == "url")
                                ? Center(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.contain,
                                                colorFilter:
                                                    new ColorFilter.mode(
                                                        Colors.white
                                                            .withOpacity(0.3),
                                                        BlendMode.dstATop),
                                                image: AssetImage(
                                                  "assets/images/shop.png",
                                                ),
                                              )),
                                            ),
                                            Positioned(
                                              top: 100,
                                              left: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.0),
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PictureSelection(
                                                                    data["ShopName"]
                                                                        .toString())),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.edit_rounded,
                                                      color: Colors.black87,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                : Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      height: 200,
                                      width: 200,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: PinchZoom(
                                                maxScale: 3.5,
                                                resetDuration:
                                                    Duration(microseconds: 100),
                                                zoomedBackgroundColor: Colors
                                                    .black
                                                    .withOpacity(0.5),
                                                image: CachedNetworkImage(
                                                  imageUrl: imgURL,
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
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.5),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PictureSelection(data[
                                                                      "ShopName"]
                                                                  .toString())),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.edit_rounded,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        /* FlatButton(
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
                            )), */
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              data["ShopName"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  color: Colors.black87,
                                  fontSize: 32,
                                  letterSpacing: 1.5),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Category :   " + data["Category"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'OpenSans',
                                color: Colors.black87,
                              ),
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
