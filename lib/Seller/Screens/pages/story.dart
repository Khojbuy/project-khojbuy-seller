import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference referenceSeller =
    FirebaseFirestore.instance.collection('SellerData');
final CollectionReference referenceStories =
    FirebaseFirestore.instance.collection("Stories");

class StoryAddPage extends StatefulWidget with NavigationStates {
  @override
  _StoryAddPageState createState() => _StoryAddPageState();
}

class _StoryAddPageState extends State<StoryAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color.fromRGBO(41, 74, 171, 0.98),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          child: InkWell(
            autofocus: true,
            onTap: () async {},
            child: Text(
              "Upload New",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "THIS FEATURE WILL ARRIVE SOON",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromRGBO(41, 74, 171, 1)),
            ),
          ),
        ));
  }
}

addFireStore(List<String> imgURL) {
  referenceSeller.doc(FirebaseAuth.instance.currentUser.uid).update({});
}
