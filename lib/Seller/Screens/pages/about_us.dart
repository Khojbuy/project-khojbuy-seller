import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Screens/pages/policies/dialouge.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class ContactInfo extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 10),
            child: Text(
              "What is KHOJBUY ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Color.fromRGBO(84, 176, 243, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: about(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color.fromRGBO(84, 176, 243, 0.98),
                child: InkWell(
                  child: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.shortestSide * 0.35,
                      height: MediaQuery.of(context).size.longestSide * 0.05,
                      child: Center(
                        child: Text(
                          'Terms & Conditions',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialougePop(mdFileName: "tnc.md");
                          });
                    },
                  ),
                ),
              ),
              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color.fromRGBO(84, 176, 243, 0.98),
                child: InkWell(
                  child: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.shortestSide * 0.35,
                      height: MediaQuery.of(context).size.longestSide * 0.05,
                      child: Center(
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialougePop(mdFileName: "privacy.md");
                          });
                    },
                  ),
                ),
              )
            ],
          ),
          Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            color: Color.fromRGBO(84, 176, 243, 0.98),
            child: InkWell(
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.7,
                  height: MediaQuery.of(context).size.longestSide * 0.05,
                  child: Center(
                    child: Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DialougePop(mdFileName: "faq.md");
                      });
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}

Text about() {
  final String aboutText =
      "We help you find the most appropriate shop where you can get your desired products, saving a lot of your precious time. Search for a product, and find the shop you can buy it from, and at the most suited price. Save the amount of time and effort!\n\n"
      "Finding a particular product, the way you want it, and at the right price, from the numerous shops can be time-consuming and arduous. We, at Khojbhuy, make this process easy and direct for you. All you need to do is from among the enormous range (via name or picture), and in a particular category, and the app presents to you the store you can contact or reach to buy it, at the best possible price, at your fingertips. We are now functional in Sambalpur, Odisha.\n\n";
  return Text(
    aboutText,
    textAlign: TextAlign.justify,
    style: TextStyle(
        fontFamily: 'OpenSans',
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16),
  );
}
