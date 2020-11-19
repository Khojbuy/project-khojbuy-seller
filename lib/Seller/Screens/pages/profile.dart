import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');

class ProfilePage extends StatefulWidget with NavigationStates {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Check your Internet Connection",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (data["PhotoURL"] == "url")
                    ? CircleAvatar(
                        radius: 80,
                        child: Image.asset("assets/images/shop.png"),
                      )
                    : CircleAvatar(
                        radius: 80,
                        child: Image.file(data["PhotoURL"]),
                      ),
                Text(
                  data["ShopName"],
                  style: TextStyle(
                    color: Color.fromRGBO(41, 74, 171, 1),
                    fontSize: 25,
                  ),
                ),
                Text(
                  data["Name"] + "   " + data["PhoneNo"],
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(41, 74, 171, 0.6),
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  initialValue: data["AddressLocation"].toString(),
                  decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      fillColor: Colors.white),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Address cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
