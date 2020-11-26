import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Order');
List<String> stats = ["received", " confirmed", "to pack", "completed"];

StreamBuilder orderTile(String orderStatus, BuildContext context) {
  return StreamBuilder(
    stream: users
        .where("Seller",
            isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
        .where("Status", isEqualTo: orderStatus)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: Text(
            "You have no orders in this status",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      }

      return ListView(
          scrollDirection: Axis.vertical,
          children: snapshot.data.documents.map<Widget>((doc) {
            return Card(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              elevation: 20,
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(doc['CustomerName'])),
            );
          }).toList());
    },
  );
}

orderPieces(AsyncSnapshot snapshot) {
  return snapshot.data.documents.map((doc) => ListTile(
        title: doc["CustomerName"],
      ));
}

class OrderPage extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String userID;
  const OrderPage({Key key, this.snapshot, this.userID}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState(snapshot, userID);
}

class _OrderPageState extends State<OrderPage> {
  final DocumentSnapshot documentSnapshot;
  final String userID;

  _OrderPageState(this.documentSnapshot, this.userID);
  @override
  Widget build(BuildContext context) {
    String remark = documentSnapshot['Remarks'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          documentSnapshot['CustomerName'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (documentSnapshot['Status'] == 'received')
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Choose the items available with you"),
                  )
                : Container(),
            ListView.builder(
                padding: EdgeInsets.all(12.0),
                shrinkWrap: true,
                itemCount: documentSnapshot['Items'].length,
                itemBuilder: (context, index) {
                  bool availability =
                      documentSnapshot['Items'][index]['Availability'];
                  String itemName =
                      documentSnapshot['Items'][index]['ItemName'];
                  String amount = documentSnapshot['Items'][index]['Amount'];
                  return SwitchListTile(
                      title: Text(
                        itemName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        amount,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      activeColor: Colors.blue,
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      value: availability,
                      onChanged: (val) {
                        availability = val;
                      });
                }),
            (documentSnapshot['image'] == 'url')
                ? Container(
                    child: Text(
                        "${documentSnapshot['CustomerName']} attached no image for this order."),
                  )
                : Image.network(
                    documentSnapshot['image'],
                    fit: BoxFit.cover,
                    height: 350,
                    width: 350,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        child: Text("Please check your internet connection"),
                      );
                    },
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: TextFormField(
                initialValue: remark,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "Additional details(if any)",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    fillColor: Colors.white),
                onChanged: (value) {
                  setState(() {
                    remark = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: InkWell(
                onTap: () {
                  int index = stats.indexOf(documentSnapshot['Status']);
                  users.doc(userID).update({
                    'Status': stats[index++],
                    'Remarks': remark,
                  }).whenComplete(() => print("Status Updated"));
                  Navigator.of(context).pop();
                },
                child: Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
