import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Buyer/Screens/homepage_buyer.dart';
import 'package:khojbuy/Seller/Screens/homepage_seller.dart';
import 'package:khojbuy/Buyer/initials/details_input_buyer.dart';
import 'package:khojbuy/Seller/initials/details_input_seller.dart';
import 'package:khojbuy/get_started.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences pref;

initprefs() async {
  pref = await SharedPreferences.getInstance();
}

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (pref.getString('type') == 'buyer')
            return HomePageBuyer();
          else
            return HomePageSeller();
        } else
          return GetStarted();
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

  signInBuyer(AuthCredential authCredential, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
    pref.setString('type', 'buyer');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsInputBuyer()),
    );
  }

  signInwithOTPBuyer(String smsCode, String verId, BuildContext context) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signInBuyer(authCredential, context);
  }

  signInSeller(AuthCredential authCredential, BuildContext context) {
    pref.setString('type', 'seller');
    FirebaseAuth.instance.signInWithCredential(authCredential);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsInputSeller()),
    );
  }

  signInwithOTPSeller(String smsCode, String verId, BuildContext context) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signInSeller(authCredential, context);
  }
}
