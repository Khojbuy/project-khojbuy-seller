import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'dart:async';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formkey = new GlobalKey<FormState>();
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
              color: Color.fromRGBO(255, 255, 250, 1),
              gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                            width: 250,
                            child: TextFormField(
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
                            ? AuthService()
                                .signInwithOTP(smsCode, verificationId, context)
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
      AuthService().signIn(authResult, context);
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
