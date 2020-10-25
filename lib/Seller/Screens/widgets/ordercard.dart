import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Models/modelcard.dart';

Widget cardPlate(Cards card, BuildContext context, Function ontap) {
  return Card(
    elevation: 10,
    shadowColor: Colors.blueGrey[400],
    color: Color.fromRGBO(41, 74, 171, 0.98),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        height: MediaQuery.of(context).size.longestSide * 0.2,
        width: double.infinity,
        child: Text(card.name),
      ),
    ),
  );
}
