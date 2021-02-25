import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/story_add.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';

import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference referenceSeller =
    FirebaseFirestore.instance.collection('SellerData');

class StoryAdd extends StatefulWidget with NavigationStates {
  @override
  _StoryAddState createState() => _StoryAddState();
}

class _StoryAddState extends State<StoryAdd> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: referenceSeller.doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          String city = snapshot.data['AddressCity'];

          String userID = snapshot.data.id;
          return FutureBuilder(
            future:
                FirebaseFirestore.instance.collection(city).doc(userID).get(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snap.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<dynamic> storyList = snap.data['stories'];
                var present = Timestamp.now();

                for (var i = 0; i < storyList.length; i++) {
                  if (present
                          .toDate()
                          .difference(storyList[i]['time'].toDate())
                          .inDays >=
                      7) {
                    FirebaseStorage.instance
                        .ref()
                        .child("Story/$city/$userID/$i")
                        .delete();
                    storyList.removeWhere((element) {
                      return present
                              .toDate()
                              .difference(element['time'].toDate())
                              .inDays >=
                          7;
                    });
                  }
                }

                FirebaseFirestore.instance
                    .collection(city)
                    .doc(userID)
                    .update({'stories': storyList});
                return Scaffold(
                    key: _scaffoldKey,
                    floatingActionButton: FloatingActionButton(
                      elevation: 20,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      backgroundColor:
                          Color.fromRGBO(84, 176, 243, 1).withOpacity(0.85),
                      onPressed: () {
                        if (storyList.length == 5) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.black54,
                              content: Text(
                                "You can add maximum 5 stories only. Delete the oldest one and you are good to go.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 20),
                              )));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StoryAddPage(storyList, city, userID)));
                        }
                      },
                    ),
                    body: WillPopScope(
                      onWillPop: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            ListView.builder(
                                itemCount: storyList.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: ListTile(
                                      dense: true,
                                      title: Text(
                                        "Created at - " +
                                            storyList[index]['time']
                                                .toDate()
                                                .toString()
                                                .substring(0, 16),
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Container(
                                        height: 40,
                                        padding: EdgeInsets.only(left: 12.0),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              size: 32,
                                              color: Color.fromRGBO(
                                                      84, 176, 243, 1)
                                                  .withOpacity(0.85),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                storyList.removeAt(index);
                                                FirebaseFirestore.instance
                                                    .collection(city)
                                                    .doc(userID)
                                                    .update(
                                                        {'stories': storyList});
                                              });
                                            }),
                                      ),
                                      leading: Container(
                                        height: 100,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              width: 5.0,
                                              color: Colors.black26),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: storyList[index]['url'],
                                          fadeInCurve: Curves.easeIn,
                                          fit: BoxFit.cover,
                                          fadeOutDuration:
                                              Duration(microseconds: 100),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              SizedBox(
                                                  height: 10,
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "You can add maximum 5 stories and each would last for 7 days at max.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 14,
                                    color: Colors.black87),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              }
            },
          );
        }
      },
    );
  }
}
