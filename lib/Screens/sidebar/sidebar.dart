import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          color: Color.fromRGBO(41, 74, 171, 0.6),
        )),
        Align(
          alignment: Alignment(0, -0.9),
          child: Container(
            width: 35,
            height: 110,
            color: Color.fromRGBO(41, 74, 171, 0.6),
          ),
        )
      ],
    );
  }
}
