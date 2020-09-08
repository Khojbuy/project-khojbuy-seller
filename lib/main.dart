import 'package:flutter/material.dart';
import 'get_started.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff292b3a),
          fontFamily: 'Nunito',
          brightness: Brightness.light,
        ),
        home: GetStarted(),
      ),
    );
  }
}
