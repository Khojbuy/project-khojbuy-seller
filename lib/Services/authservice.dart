import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Initials/details_input_seller.dart';
import 'package:khojbuy/Seller/Screens/homepage_seller.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';
import 'package:khojbuy/get_started.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return GetStarted();
        }
      },
    );
  }

  signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GetStarted()),
    );
  }

  signInSeller(
    AuthCredential authCredential,
    BuildContext context,
  ) async {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
      FirebaseFirestore.instance
          .collection("SellerData")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageSeller()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsInputSeller()),
          );
        }
      });
    });
  }

  signInwithOTPSeller(String smsCode, String verId, BuildContext context) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signInSeller(authCredential, context);
  }
}
