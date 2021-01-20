import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/dashboard.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuth(),
      routes: {
        '/dashboard': (context) => DashBoardPage(),
      },
    );
  }
}
