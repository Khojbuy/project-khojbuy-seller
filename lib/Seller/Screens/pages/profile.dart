import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('SellerData');
final Reference reference = FirebaseStorage.instance.ref();
final snackbar = SnackBar(
    content: Text(
        "Profile Updated ! Changes might take some time to reflect \n Restart the app in case you dont see the changes"));

class ProfilePage extends StatefulWidget with NavigationStates {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
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
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'OpenSans',
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          String imgURL = data["PhotoURL"];
          String addLoc = data["AddressLocation"];
          String addCity = data["AddressCity"];
          bool delivery = data["Delivery"];
          String dealsIn = data["DealsIn"];
          String otherInfo = data["Other"];

          return StatefulBuilder(builder: (context, function) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (imgURL == "url")
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 80,
                                child: Image.asset(
                                  "assets/images/shop.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.network(
                                  imgURL,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                            ),
                      FlatButton(
                          textColor: Colors.blueAccent,
                          onPressed: () async {
                            print(imgURL);
                            final picker = ImagePicker();
                            final storage = FirebaseStorage.instance;

                            PickedFile image = await picker.getImage(
                                source: ImageSource.gallery);
                            File img = File(image.path);
                            if (img != null) {
                              TaskSnapshot snapshot = await storage
                                  .ref()
                                  .child("SellerData/${data["Name"]}")
                                  .putFile(img);
                              String downloadURL =
                                  await snapshot.ref.getDownloadURL();
                              print(downloadURL);
                              setState(() {
                                imgURL = downloadURL;
                                print(imgURL);
                              });
                            } else {
                              print("No path recived");
                            }
                          },
                          child: Text(
                            "Change Photo",
                          )),
                      Text(
                        "The changes will be visible after you SAVE them",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          data["ShopName"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              color: Color.fromRGBO(84, 176, 243, 1),
                              fontSize: 32,
                              letterSpacing: 2.5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          data["Name"] +
                              " " +
                              data["PhoneNo"].toString().substring(3),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'OpenSans',
                            fontSize: 24,
                            color: Color.fromRGBO(84, 176, 243, 1),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Shop Category : " + data["Category"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            color: Color.fromRGBO(84, 176, 243, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        width: 200,
                        child: Divider(
                          color: Colors.white10,
                        ),
                      ),
                      Form(
                        key: keyForm,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                minLines: 2,
                                maxLines: 4,
                                autofocus: false,
                                initialValue: dealsIn,
                                decoration: new InputDecoration(
                                    labelText: "Deals In",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    dealsIn = val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter this information';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                autofocus: false,
                                initialValue: addLoc,
                                decoration: new InputDecoration(
                                    labelText: "Shop Location ",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    addLoc = val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Shop Location';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                autofocus: false,
                                initialValue: addCity,
                                decoration: new InputDecoration(
                                    labelText: "Shop City",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          minLines: 2,
                          maxLines: 4,
                          autofocus: false,
                          initialValue: otherInfo,
                          decoration: new InputDecoration(
                              labelText: "Other Information",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              fillColor: Colors.white),
                          onSaved: (val) {
                            setState(() {
                              otherInfo = val;
                            });
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 25),
                          child: InkWell(
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                keyForm.currentState.validate();
                                updateUserData(users, addLoc, addCity, delivery,
                                        data, dealsIn, otherInfo)
                                    .then((value) {
                                  Scaffold.of(context).showSnackBar(snackbar);
                                });
                              },
                              elevation: 10,
                              backgroundColor:
                                  Color.fromRGBO(84, 176, 243, 0.6),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Save Data",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'OpenSans',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

Future updateUserData(
    CollectionReference collectionReference,
    String addLoc,
    String addCity,
    bool del,
    Map<String, dynamic> data,
    String dealsIn,
    String info) async {
  String imgURL =
      await reference.child("SellerData/${data["Name"]}").getDownloadURL();
  print(imgURL);
  return await collectionReference
      .doc(FirebaseAuth.instance.currentUser.uid)
      .update({
    "PhotoURL": imgURL,
    "AddressLocation": addLoc,
    "AddressCity": addCity,
    "Delivery": del,
    "DealsIn": dealsIn,
    "Other": info
  }).then((value) {
    print("User Added");
  }).catchError((error) => print(error));
}
