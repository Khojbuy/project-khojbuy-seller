import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Request');

List<String> stats = ["new", "responded"];

Future<String> getCategory() async {
  final DocumentSnapshot category = await FirebaseFirestore.instance
      .collection("SellerData")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();

  return category["Category"];
}

StreamBuilder requestTile(String status, BuildContext context) {
  String cat;
  getCategory().then((value) {
    cat = value;
    print(cat);
  });
  return StreamBuilder(
      stream: users
          .where("Category", isEqualTo: cat)
          .where("Status", isEqualTo: status)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data.documents.toString() == "[]") {
          return Center(
            child: Text(
              "You have no requests in this status",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          print(snapshot.data.documents);
          return Column(
            children: snapshot.data.documents.map<Widget>((doc) {
              print(doc.data());
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
                    title: Text(doc["Customer"]),
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
    List<dynamic> items = documentSnapshot['Items'];
    String userID = documentSnapshot.id;
    print(items);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          documentSnapshot['Customer'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                users.doc(userID).delete();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Request Deleted"),
                  elevation: 20,
                ));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (documentSnapshot["Status"] == 'new')
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("If you have all the listed items, PROCEED"),
                  )
                : Container(),
            ListView.builder(
                padding: EdgeInsets.all(12.0),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      items[index]['ItemName'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      items[index]['ItemNo'],
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                }),
            (documentSnapshot['Image'] == 'url')
                ? Container(
                    child: Text(
                        "${documentSnapshot['Customer']} attached no image for this request."),
                  )
                : Image.network(
                    documentSnapshot['Image'],
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
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 12.0),
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
            documentSnapshot["Status"] == "new"
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                          users.doc(userID).update(
                              {"Remarks": remark, "Status": "responded"});
                          Navigator.of(context).pop();
                        }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
