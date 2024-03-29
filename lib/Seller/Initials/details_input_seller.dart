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
      dealsIn = " ",
      info = " ",
      minAmt = " ";
  bool delivery = false;
  String selectCategory = " ";

  String phnNo, verificationId, smsCode;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        fontFamily: 'OpenSans',
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
                                    labelText: "Enter your Shop Name",
                                    hintText: "John Enterprises",
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    this.shopName = val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Shop Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                    labelText: "Enter your Name",
                                    hintText: "John Doe",
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    this.ownerName = val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: new InputDecoration(
                                    labelText: "Enter Your Contact Number",
                                    hintText: "9996663333",
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    this.phnNo = "+91" + val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty && value.length != 10) {
                                    return 'Please enter a valid mobile number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DropdownButtonFormField(
                                  items: [
                                    "Automotive",
                                    "Boutique & Personal Care",
                                    "Clothing",
                                    "Electrical & Electronics",
                                    "Fashion",
                                    "Food & Restaurant",
                                    "Furniture",
                                    "Grocery & Daily Needs",
                                    "Hardware & Machinery",
                                    "Health & Fitness",
                                    "Home Essentials & Decor",
                                    "Jewellery",
                                    "Mobile & Computers",
                                    "Pets & Care",
                                    "Stationery & Books",
                                    "Tiles & Sanitary Wares"
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
                                    labelText: "Enter your Shop's Location",
                                    hintText: "Laxmi Talkies Road",
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    this.addressLoc = val;
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
                              TextFormField(
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                decoration: new InputDecoration(
                                    labelText: "Deal In",
                                    hintText:
                                        "All sorts of school books and stationery",
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    this.dealsIn = val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'This feild can not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                decoration: new InputDecoration(
                                    labelText: "Other information(if any)",
                                    hintText:
                                        "Home Delivery is not available on Weekends",
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    fillColor: Colors.white),
                                onSaved: (val) {
                                  setState(() {
                                    this.info = val;
                                  });
                                },
                                textInputAction: TextInputAction.next,
                              ),
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
                          formkey.currentState.validate();
                          formkey.currentState.save();

                          DatabaseService(
                                  userId: FirebaseAuth.instance.currentUser.uid)
                              .updateUserData(Seller(
                                  shopName,
                                  ownerName,
                                  phnNo,
                                  selectCategory,
                                  delivery,
                                  addressLoc,
                                  addressCity,
                                  dealsIn,
                                  info));
                          DatabaseService(
                                  userId: FirebaseAuth.instance.currentUser.uid)
                              .updateStoryData(
                                  phnNo, shopName, addressCity, selectCategory);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        elevation: 10,
                        backgroundColor: Color.fromRGBO(84, 176, 243, 0.8),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
