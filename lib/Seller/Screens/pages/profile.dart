import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');
final snackbar = SnackBar(content: Text("Profile Updated !"));

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
          String addLoc = data["AddressLocation"];
          String addCity = data["AddressCity"];
          bool delivery = data["Delivery"];
          String deliveryAmt = data["MinAmt"];
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    data["ShopName"],
                    style: TextStyle(
                      color: Color.fromRGBO(41, 74, 171, 1),
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    data["Name"] + "   " + data["PhoneNo"],
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(41, 74, 171, 0.6),
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    data["Category"],
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(41, 74, 171, 0.6),
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    initialValue: addLoc,
                    decoration: new InputDecoration(
                        labelText: "Shop Location ",
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
                      setState(() {
                        addLoc = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    initialValue: addCity,
                    decoration: new InputDecoration(
                        labelText: "Shop City",
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
                      setState(() {
                        addCity = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SwitchListTile(
                      title: Text(
                        "Home Delivery Facility",
                        style: TextStyle(color: Colors.black),
                      ),
                      value: delivery,
                      onChanged: (val) {
                        setState(() {
                          delivery = val;
                        });
                      }),
                ),
                delivery
                    ? Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          initialValue: deliveryAmt,
                          decoration: new InputDecoration(
                              labelText: "Minimum Amount for home delivery ",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              fillColor: Colors.white),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Amount cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              addCity = val;
                            });
                          },
                        ),
                      )
                    : Container(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                    child: InkWell(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          updateUserData(
                              users, addLoc, addCity, delivery, deliveryAmt);
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        elevation: 10,
                        backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            "Save Data",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Nunito',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
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

Future updateUserData(CollectionReference collectionReference, String addLoc,
    String addCity, bool del, String minAmt) async {
  return await collectionReference
      .doc(FirebaseAuth.instance.currentUser.uid)
      .set({
    "AddressLocation": addLoc,
    "AddressCity": addCity,
    "Delivery": del,
    "MinAmt": minAmt,
  }).then((value) {
    print("User Added");
  }).catchError((error) => print(error));
}
