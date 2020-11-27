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
        decoration: BoxDecoration(color: Color.fromRGBO(41, 74, 171, 0.98)),
        child: InkWell(
          autofocus: true,
          onTap: () {},
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}

addFireStore(List<String> imgURL) {
  referenceSeller.doc(FirebaseAuth.instance.currentUser.uid).update({});
}
