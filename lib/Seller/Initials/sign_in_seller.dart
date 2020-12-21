import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Services/authservice.dart';

class SignInSeller extends StatefulWidget {
  @override
  _SignInSellerState createState() => _SignInSellerState();
}

class _SignInSellerState extends State<SignInSeller> {
  final formkey = new GlobalKey<FormState>();
  String phnNo, verificationId, smsCode;
  bool codeSent = false;
  String status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          height: double.infinity,
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
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    "assets/images/logo.jpg",
                  ),
                ),
                Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 38,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 20,
                ),
                codeSent
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width:
                              MediaQuery.of(context).size.shortestSide * 0.85,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: new InputDecoration(
                                hintText: "Enter Your Mobile Number",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
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
                          formkey.currentState.save();
                          codeSent
                              ? AuthService().signInwithOTPSeller(
                                  smsCode,
                                  verificationId,
                                  context,
                                )
                              : verifyPhone(
                                  phnNo,
                                );
                        },
                        elevation: 10,
                        backgroundColor: Color.fromRGBO(84, 176, 243, 0.8),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            codeSent ? "Login" : "Verify",
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
    );
  }

  Future<void> verifyPhone(String phnNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signInSeller(authResult, context);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) async {
      setState(() {
        this.codeSent = true;
        print("code sent to " + phnNo);
      });
      this.verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
      setState(() {
        this.status = "Auto retreival time out";
      });
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
