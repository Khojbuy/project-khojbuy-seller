import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Request');

String city, categoryName;
Future<String> getCategory() async {
  final DocumentSnapshot category = await FirebaseFirestore.instance
      .collection("SellerData")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();

  categoryName = category["Category"];
  city = category['AddressCity'];
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
              return InkWell(
                onTap: () {
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
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  elevation: 20,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Text(doc["Customer"]),
                    subtitle: Text("has requested " + doc['Item'].toString()),
                  ),
                ),
              );
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
  String items;
  String image;
  String requestID;

  _RequestPageState(this.documentSnapshot, this.status);

  @override
  void initState() {
    items = documentSnapshot['Item'];
    image = documentSnapshot['Image'];
    requestID = documentSnapshot.id;
    super.initState();
  }

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
            IconButton(
                color: Colors.white,
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  users
                      .doc(requestID)
                      .update({FirebaseAuth.instance.currentUser.uid: -1});

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Request Deleted"),
                    elevation: 20,
                  ));

                  (status == 'new')
                      ? Navigator.of(context).pop()
                      : users
                          .doc(requestID)
                          .collection('SellerResponses')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .delete()
                          .then((value) => Navigator.of(context).pop());
                })
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
                      requestID.toLowerCase(),
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
                      items,
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
                child: image == 'url'
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
                              image,
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                      ),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            splashColor: Colors.blue,
                            color: Color.fromRGBO(84, 176, 243, 1),
                            onPressed: () {}),
                      ),
                    )
                  : Container()
            ],
          ),
        )
        /*  StatefulBuilder(
          builder: (context, setstate) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (documentSnapshot["Status"] == 'new')
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Text("If you have all the listed items, PROCEED"),
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
                            items[index]['Amount'],
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: SizedBox(
                              width: MediaQuery.of(context).size.shortestSide *
                                  0.4,
                              child: (documentSnapshot["Status"] == 'new')
                                  ? Row(
                                      children: [
                                        Text(
                                          "₹  ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.3,
                                          child: TextFormField(
                                            initialValue: items[index]['Price']
                                                .toString(),
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                                hintText: "Cost",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'OpenSans')),
                                            onChanged: (value) {
                                              setState(() {
                                                print(value);
                                                items[index]['Price'] = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      child: Text(
                                        '₹' + items[index]['Price'].toString(),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Customer Remarks - ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans"),
                        ),
                        Text(
                          documentSnapshot["BuyerRemark"],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans"),
                        ),
                      ],
                    ),
                  ),
                  (documentSnapshot["Status"] == 'new')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32.0, horizontal: 12.0),
                          child: TextFormField(
                            initialValue: sellerRemark,
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
                                sellerRemark = value;
                              });
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Your Remarks - ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                documentSnapshot["SellerRemark"],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans"),
                              ),
                            ],
                          ),
                        ),
                  (documentSnapshot['Image'] == 'url')
                      ? Container(
                          child: Text(
                              "${documentSnapshot['CustomerName']} attached no image for this request."),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(
                            documentSnapshot['Image'],
                            fit: BoxFit.contain,
                            height:
                                MediaQuery.of(context).size.longestSide * 0.3,
                            width:
                                MediaQuery.of(context).size.longestSide * 0.3,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                child: Text(
                                    "Please check your internet connection"),
                              );
                            },
                          ),
                        ),
                  documentSnapshot["Status"] == "new"
                      ? Padding(
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
                              color: Color.fromRGBO(84, 176, 243, 1),
                              onPressed: () {
                                print(items);
                                updateRequest(items, sellerRemark, userID);
                                Navigator.of(context).pop();
                              }),
                        )
                      : Container()
                ],
              ),
            );
          },
        ) */
        );
  }
}
