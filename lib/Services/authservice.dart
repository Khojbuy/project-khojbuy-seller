import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/seller.dart';
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

  signInSeller(AuthCredential authCredential, BuildContext context,
      Seller seller) async {
    final sellerDataRef =
        FirebaseDatabase.instance.reference().child('SellerData');
    print(FirebaseAuth.instance.currentUser.phoneNumber);
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((userCredential) {
      seller.userId = FirebaseAuth.instance.currentUser.uid;
    });
    print(seller.userId);
    setData(seller, sellerDataRef);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  signInwithOTPSeller(
      String smsCode, String verId, BuildContext context, Seller seller) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signInSeller(authCredential, context, seller);
  }
}

setData(Seller seller, DatabaseReference ref) {
  ref.push().set(toJsonSeller(seller));
}
