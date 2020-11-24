import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/seller.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';

class DetailsInputSeller extends StatefulWidget {
  @override
  _DetailsInputSellerState createState() => _DetailsInputSellerState();
}

class _DetailsInputSellerState extends State<DetailsInputSeller> {
  final formkey = new GlobalKey<FormState>();

  String shopName = " ",
      ownerName = " ",
      addressLoc = " ",
      addressCity = " ",
      minAmt = " ";
  bool delivery = false;
  String selectCategory = " ";

  String phnNo, verificationId, smsCode;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.longestSide * 0.15,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "SELLER INFORMATION",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 38,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.shortestSide * 0.85,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                    hintText: "Enter your Shop Name",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Shop Name cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    this.shopName = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                    hintText: "Enter your Name",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Owner Name cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    this.ownerName = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: new InputDecoration(
                                    hintText: "Enter Your Mobile Number",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Mobile Number cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    this.phnNo = "+91" + val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DropdownButtonFormField(
                                  items: [
                                    'Electronics and Electricals',
                                    'Clothing and Boutique',
                                    'Daily Needs'
                                        'Home Essentials and Decor',
                                    'Health and Medicines',
                                    'Motor Parts and Hardware',
                                    'Grocery',
                                    'Footwear',
                                    'Stationery',
                                    'Furniture',
                                    'Sanitary Wares and Ceramics'
                                  ].map((String category) {
                                    return new DropdownMenuItem(
                                        value: category,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              category.toString(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ));
                                  }).toList(),
                                  decoration: InputDecoration(
                                      hintText: "Enter Your Shop Category",
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                      fillColor: Colors.white),
                                  onChanged: (val) {
                                    setState(() {
                                      this.selectCategory = val;
                                    });
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                decoration: new InputDecoration(
                                    hintText: "Enter your Shop's Location",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
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
                                    this.addressLoc = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DropdownButtonFormField(
                                  items: ["Angul", "Sambalpur"]
                                      .map((String category) {
                                    return new DropdownMenuItem(
                                        value: category,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              category,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ));
                                  }).toList(),
                                  decoration: InputDecoration(
                                      hintText: "Enter Your City",
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                      fillColor: Colors.white),
                                  onChanged: (val) {
                                    setState(() {
                                      this.addressCity = val;
                                    });
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              ListTile(
                                title: Text(
                                    " Do you have home delivery facility ? "),
                                trailing: Switch(
                                  activeColor: Colors.blueAccent,
                                  value: this.delivery,
                                  onChanged: (value) {
                                    setState(() {
                                      this.delivery = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              delivery
                                  ? TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: new InputDecoration(
                                          hintText:
                                              "Enter the minimum amount for home delivery",
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
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
                                          this.minAmt = val;
                                        });
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                    child: InkWell(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          formkey.currentState.save();
                          DatabaseService(
                                  userId: FirebaseAuth.instance.currentUser.uid)
                              .updateUserData(Seller(
                                  shopName,
                                  ownerName,
                                  phnNo,
                                  selectCategory,
                                  delivery,
                                  minAmt,
                                  addressLoc,
                                  addressCity));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
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
                SizedBox(
                  height: MediaQuery.of(context).size.longestSide * 0.15,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
