import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Screens/dashboard.dart';
import 'package:khojbuy/Screens/details_input.dart';
import 'package:khojbuy/Screens/get_started.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData)
          return DashBoardPage();
        else
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

  signIn(AuthCredential authCredential, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsInput()),
    );
  }

  signInwithOTP(String smsCode, String verId, BuildContext context) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCredential, context);
  }
}
