import 'package:flutter/material.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthService().handleAuth(),
        );
      },
    );
  }
}
