import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Order');
//List<String> stats = ["received", "waiting", "to pack", "completed"];

StreamBuilder orderTile(String orderStatus, BuildContext context) {
  return StreamBuilder(
    stream: (orderStatus == "received")
        ? users
            .where("Seller",
                isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
            .where("Status", whereIn: ["received", "waiting"]).snapshots()
        : users
            .where("Seller",
                isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
            .where("Status", isEqualTo: orderStatus)
            .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!snapshot.hasData || snapshot.data.documents.toString() == "[]") {
        return Center(
          child: Text(
            "You have no orders in this status",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      }
      if (snapshot.hasData) {
        return Column(
          children: snapshot.data.documents.map<Widget>((doc) {
            return InkWell(
              onTap: () {
                print(doc);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderPage(
                            snapshot: doc,
                            orderStatus: doc["Status"],
                          )),
                );
              },
              child: Card(
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                elevation: 20,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(doc['CustomerName']),
                      doc["Status"] == "waiting"
                          ? Text(
                              "waiting for customer's response",
                              style: TextStyle(
                                  color: Color.fromRGBO(41, 74, 171, 1),
                                  fontSize: 12),
                            )
                          : Container(),
                    ],
                  ),
                  subtitle: Text("has ordered " +
                      doc['Items'].length.toString() +
                      " items"),
                ),
              ),
            );
          }).toList(),
        );
      }

      return CircularProgressIndicator();
    },
  );
}

class OrderPage extends StatefulWidget {
  final DocumentSnapshot snapshot;

  final String orderStatus;
  const OrderPage({Key key, this.snapshot, this.orderStatus}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState(snapshot, orderStatus);
}

class _OrderPageState extends State<OrderPage> {
  final DocumentSnapshot documentSnapshot;

  final String orderStatus;
  _OrderPageState(this.documentSnapshot, this.orderStatus);
  @override
  Widget build(BuildContext context) {
    String remark = documentSnapshot['Remarks'];
    List<dynamic> items = documentSnapshot['Items'];
    String userID = documentSnapshot.id;
    print(items);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            documentSnapshot['CustomerName'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
        ),
        body: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (orderStatus == 'received')
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Choose the items available with you"),
                        )
                      : Container(),
                  (orderStatus == 'received')
                      ? ListView.builder(
                          padding: EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          itemCount: documentSnapshot['Items'].length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              checkColor: Color.fromRGBO(41, 74, 171, 1),
                              dense: true,
                              title: Text(
                                items[index]['ItemName'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                items[index]['Amount'],
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: items[index]['Availability'],
                              selected: items[index]['Availability'],
                              onChanged: (value) {
                                setState(() {
                                  items[index]['Availability'] = value;
                                });
                              },
                            );
                          })
                      : ListView.builder(
                          padding: EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          itemCount: documentSnapshot['Items'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                items[index]['ItemName'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    items[index]['Amount'],
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  items[index]['Availability']
                                      ? Text(
                                          "Marked Available",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Text(
                                          "Marked Unavailable",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                ],
                              ),
                            );
                          },
                        ),
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
                              child:
                                  Text("Please check your internet connection"),
                            );
                          },
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 12.0),
                    child: TextFormField(
                      initialValue: remark,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: "Additional details(if any)",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                  orderStatus == "completed" || orderStatus == "waiting"
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              textColor: Colors.white,
                              child: Text(
                                "PROCEED",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              splashColor: Colors.blue,
                              color: Color.fromRGBO(41, 74, 171, 1),
                              onPressed: () {
                                print(items);
                                String newStats;
                                if (orderStatus == "received") {
                                  newStats = "waiting";
                                } else {
                                  newStats = "completed";
                                }
                                print(newStats);
                                users.doc(userID).update({
                                  "Items": items,
                                  "Remarks": remark,
                                  "Status": newStats,
                                });
                                Navigator.of(context).pop();
                              }),
                        )
                ],
              ),
            );
          },
        ));
  }
}
