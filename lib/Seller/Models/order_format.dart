import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Order');
List<String> stats = ["recieved", " confirmed", "to pack", "completed"];

class OrderFormat {
  String name = '';
  int count = 0;
  List<String> itemNames = [];
  List<String> quantity = [];
  List<bool> availabilty = [];
  String status = 'recieved';
  String remarks = '';
}

StreamBuilder orderTile(String orderStatus, BuildContext context) {
  return StreamBuilder(
    stream: users
        .where("Seller", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where("Status", isEqualTo: orderStatus)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final ups = snapshot.data.documents;
        return ListView.builder(
            itemExtent: 50,
            scrollDirection: Axis.vertical,
            itemCount: ups.length,
            itemBuilder: (context, index) {
              DocumentSnapshot products = snapshot.data.documents[index];
              return GestureDetector(
                onTap: () {},
                child: ListTile(
                  title: Text(products['CustomerName']),
                  subtitle: Text(
                      "There is an order of " + products['Count'] + " items"),
                ),
              );
            });
      }
      return Container(
        child: Text(
          "You have no orders in this status",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    },
  );
}

FutureBuilder orderPage(DocumentSnapshot snapshot, BuildContext context) {
  return FutureBuilder(builder: null);
}
