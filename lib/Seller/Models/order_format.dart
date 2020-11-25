import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');
List<String> stats = ["received", " confirmed", "to pack", "completed"];

StreamBuilder orderTile(String orderStatus, BuildContext context) {
  return StreamBuilder(
    stream: users
        //.where("Seller", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        //.where("Status", isEqualTo: orderStatus)
        .snapshots(),
    builder: (context, snapshot) {
      print(FirebaseAuth.instance.currentUser.uid);
      print(snapshot);
      if (snapshot.connectionState == ConnectionState.done &&
          !snapshot.hasData) {
        return Container(
          child: Text(
            "You have no orders in this status",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      }
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData) {
        final ups = snapshot.data.documents;
        /* return Center(
          child: Text("Data is being accessed" +
              snapshot.connectionState.toString() +
              snapshot.data.toString()),
        ); */
        ListView.builder(
            clipBehavior: Clip.antiAlias,
            shrinkWrap: true,
            itemExtent: 50,
            scrollDirection: Axis.vertical,
            itemCount: ups.length,
            itemBuilder: (context, index) {
              DocumentSnapshot products = snapshot.data.documents[index];
              String userID = products.id;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderPage(
                              snapshot: products,
                              userID: userID,
                            )),
                  );
                },
                child: ListTile(
                  title: Text(products['CustomerName']),
                  subtitle: Text(
                      "There is an order of " + products['Count'] + " items"),
                ),
              );
            });
      }
      return Center(child: CircularProgressIndicator());
    },
  );
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
