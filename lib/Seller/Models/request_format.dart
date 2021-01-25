import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Request');

String city, categoryName, shopName;
String remark;
String price;

getCategory() async {
  final DocumentSnapshot category = await FirebaseFirestore.instance
      .collection("SellerData")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();

  categoryName = category["Category"];
  city = category['AddressCity'];
  shopName = category['ShopName'];
}

StreamBuilder requestTile(String status, BuildContext context) {
  return StreamBuilder(
      stream: status == 'new'
          ? users
              .where("Category", isEqualTo: categoryName)
              .where("City", isEqualTo: city)
              .where(FirebaseAuth.instance.currentUser.uid, isEqualTo: 0)
              .snapshots()
          : users
              .where("Category", isEqualTo: categoryName)
              .where("City", isEqualTo: city)
              .where(FirebaseAuth.instance.currentUser.uid, isEqualTo: 1)
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
          return Column(
            children: snapshot.data.documents.map<Widget>((doc) {
              return doc['Status'] == 'active' || status == 'responded'
                  ? InkWell(
                      onTap: () async {
                        if (status != 'new') {
                          final snapShot = await users
                              .doc(doc.id)
                              .collection('SellerResponses')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .get();
                          remark = snapShot['Remark'];
                          price = snapShot['Price'];
                          print(remark);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestPage(
                                    documentSnapshot: doc,
                                    status: status,
                                  )),
                        );
                      },
                      child: Card(
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        elevation: 20,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: Text(doc["CustomerName"]),
                          subtitle:
                              Text("has requested " + doc['Item'].toString()),
                        ),
                      ),
                    )
                  : Container();
            }).toList(),
          );
        }
        print(snapshot.hasData.toString());
        return CircularProgressIndicator();
      });
}

class RequestPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String status;

  const RequestPage({Key key, this.documentSnapshot, this.status})
      : super(key: key);

  @override
  _RequestPageState createState() =>
      _RequestPageState(documentSnapshot, status);
}

class _RequestPageState extends State<RequestPage> {
  DocumentSnapshot documentSnapshot;
  String status;
  String newRemark = '';
  String newPrice = '₹ 0 ';

  _RequestPageState(this.documentSnapshot, this.status);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            status.toUpperCase() + ' REQUESTS',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          actions: [
            documentSnapshot['Status'] == 'active'
                ? IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      users
                          .doc(documentSnapshot.id)
                          .update({FirebaseAuth.instance.currentUser.uid: -1});

                      (status == 'new')
                          ? Navigator.of(context).pop()
                          : users
                              .doc(documentSnapshot.id)
                              .collection('SellerResponses')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .delete()
                              .then((value) => Navigator.of(context).pop());
                    })
                : Container()
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'REQUEST ID - ',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.06),
                    ),
                    Text(
                      documentSnapshot.id.toLowerCase(),
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.05),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'REQUEST TIME - ',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.06),
                    ),
                    Text(
                      documentSnapshot['Time']
                          .toDate()
                          .toString()
                          .substring(0, 16),
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.05),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ITEM - ',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.06),
                    ),
                    Text(
                      documentSnapshot['Item'],
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.05),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: documentSnapshot['Image'] == 'url'
                    ? Center(
                        child: Text(
                          'Customer has attached no image',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.05),
                        ),
                      )
                    : Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image.network(
                              documentSnapshot['Image'],
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                      ),
              ),
              status == 'new'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          child: TextFormField(
                            initialValue: newPrice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Enter the price for the request",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                fillColor: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                newPrice = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 12.0),
                          child: TextFormField(
                            initialValue: newRemark,
                            keyboardType: TextInputType.text,
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: "Delivery before 8pm",
                                labelText: "Additional details(if any)",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                fillColor: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                newRemark = value;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Your suggested price - ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                price.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans"),
                              ),
                            ],
                          ),
                        ),
                        remark != ''
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Your Remarks - ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "OpenSans"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          remark,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "OpenSans"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
              // Enter Price
              // Comment
              status == 'new'
                  ? Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            textColor: Colors.white,
                            child: Text(
                              "CONFIRM",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans'),
                            ),
                            splashColor: Colors.blue,
                            color: Color.fromRGBO(84, 176, 243, 1),
                            onPressed: () async {
                              final DocumentSnapshot category =
                                  await FirebaseFirestore.instance
                                      .collection("SellerData")
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .get();

                              shopName = category['ShopName'];
                              print(newPrice);
                              users.doc(documentSnapshot.id).update(
                                  {FirebaseAuth.instance.currentUser.uid: 1});
                              FirebaseFirestore.instance
                                  .collection('Request')
                                  .doc(documentSnapshot.id)
                                  .collection('SellerResponses')
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .set({
                                'ShopName': shopName,
                                'Remark': newRemark,
                                'Price': newPrice,
                              }).then((value) {
                                Navigator.of(context).pop();
                              });
                            }),
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
