import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/initials/sign_in_seller.dart';
import 'Buyer/initials/sign_in_buyer.dart';

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
                      "KHOJBUY",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(0, 0, 58, 0.8)),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Connects to the entire market to your fingertips ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                      MaterialPageRoute(
                          builder: (context) => SignInPageBuyer()),
                    );
                  },
                  elevation: 10,
                  backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                  label: Text(
                    "GET STARTED",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            RichText(
              text: new TextSpan(
                children: [
                  new TextSpan(
                    text: 'Are you a seller? ',
                    style: new TextStyle(color: Colors.black),
                  ),
                  new TextSpan(
                    text: 'Continue here',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInSeller()),
                        );
                      },
                    style: new TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
