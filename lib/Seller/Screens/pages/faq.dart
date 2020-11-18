import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Faq extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromRGBO(41, 74, 171, 0.98),
            child: InkWell(
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.longestSide * 0.1,
                  child: Center(
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromRGBO(41, 74, 171, 0.98),
            child: InkWell(
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.longestSide * 0.1,
                  child: Center(
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    ));
  }
}

terms() {
  return Scaffold(
    body: FutureBuilder(
        future: rootBundle.loadString("assets/markdowns/tnc.md"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        }),
  );
}

privacy() {
  return Scaffold(
    body: FutureBuilder(
        future: rootBundle.loadString("assets/markdowns/privacy.md"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data);
          }

          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        }),
  );
}
