import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Request');

List<String> stats = ["new", "responded"];

getCategory() async {
  final DocumentSnapshot category = await FirebaseFirestore.instance
      .collection("Seller")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();

  return category["Category"];
}

StreamBuilder requestTile(String status, BuildContext context) {
  final String cat = getCategory();
  return StreamBuilder(
      stream: users
          .where("Category", isEqualTo: cat)
          .where("Status", isEqualTo: status)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              "You have no requests in this status",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            snapshot.data.documents.map<Widget>((doc) {
              return InkWell(
                onTap: () {
                  print(doc);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestPage(
                              documentSnapshot: doc,
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
                    title: Text(doc['Customer']),
                    subtitle: Text("has ordered " +
                        doc['Items'].length.toString() +
                        " items"),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      });
}

class RequestPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const RequestPage({Key key, this.documentSnapshot}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState(documentSnapshot);
}

class _RequestPageState extends State<RequestPage> {
  final DocumentSnapshot documentSnapshot;

  _RequestPageState(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    String remark = documentSnapshot['Remarks'];
    List<Map<String, dynamic>> items = documentSnapshot['Items'];
    print(items);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          documentSnapshot['Customer'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
