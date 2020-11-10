import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Constants/categories.dart';
import 'package:khojbuy/Seller/Models/seller.dart';
import 'package:khojbuy/Services/authservice.dart';

class SignInSeller extends StatefulWidget {
  @override
  _SignInSellerState createState() => _SignInSellerState();
}

class _SignInSellerState extends State<SignInSeller> {
  final formkey = new GlobalKey<FormState>();

  String shopName = " ",
      ownerName = " ",
      addressLoc = " ",
      addressCity = " ",
      minAmt = " ";
  bool delivery = false;
  List<String> selectCategory = ["Grocery"];
  String phnNo, verificationId, smsCode;
  bool codeSent = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 240, 1),
            /*  gradient: LinearGradient(colors: [
            Color.fromRGBO(255, 255, 240, 1),
            Color.fromRGBO(245, 245, 245, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter) */
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "SIGN IN",
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
                  codeSent
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.85,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      items: category.map((String category) {
                                        return new DropdownMenuItem(
                                            value: category,
                                            child: Row(
                                              children: <Widget>[
                                                Text(category),
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
                                          selectCategory.removeLast();
                                          selectCategory.add(val);
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
                                                Text(category),
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
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0)),
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
              codeSent
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        width: 250,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter Your OTP recieved",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            fillColor: Colors.white,
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "OTP cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              this.smsCode = val;
                            });
                          },
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  child: InkWell(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        codeSent
                            ? AuthService().signInwithOTPSeller(
                                smsCode, verificationId, context)
                            : verifyPhone(phnNo);
                      },
                      elevation: 10,
                      backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          codeSent ? "Login" : "Verify",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Nunito',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> verifyPhone(String phnNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signInSeller(authResult, context);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      setState(() {
        this.codeSent = true;
      });
      this.verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phnNo,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
