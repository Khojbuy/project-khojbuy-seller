import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/policies/dialouge.dart';
import 'package:khojbuy/Seller/initials/sign_in_seller.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Container(
                padding:
                    EdgeInsets.only(top: 20.0, bottom: 10, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Khojbuy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(0, 0, 58, 0.8)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Connects the entire market to your fingertips ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(0, 0, 160, 0.8)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Image.asset('assets/images/4271981.png'),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(80)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: InkWell(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInSeller()),
                    );
                  },
                  elevation: 10,
                  backgroundColor: Color.fromRGBO(84, 176, 243, 0.8),
                  label: Text(
                    "GET STARTED",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'By creating an account, you are agreeing to our\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'OpenSans',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DialougePop(mdFileName: "tnc.md");
                                  });
                            },
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                          )),
                      TextSpan(text: " and "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DialougePop(
                                        mdFileName: "privacy.md");
                                  });
                            },
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12,
                            fontFamily: 'OpenSans',
                          ))
                    ]))

          ],
        ),
      ),
    );
  }
}
