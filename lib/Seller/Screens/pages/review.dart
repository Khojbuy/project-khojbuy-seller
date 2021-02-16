import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        },
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('SellerData')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('Review')
              .get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data.documents.toString() == '[]') {
              return Center(
                child: Text(
                  'Your shop does not have a cutomer review yet! ',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      color: Colors.black87),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 4.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('SellerData')
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .get(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            return Text(
                                'Overall Rating - ' +
                                    snapshot.data['Rating'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans'));
                          },
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.star_rounded,
                          color: Color.fromRGBO(84, 176, 243, 1),
                          size: 25,
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            dense: true,
                            enabled: true,
                            title: SmoothStarRating(
                              isReadOnly: true,
                              rating: snapshot.data.documents[index]['rating']
                                  .toDouble(),
                              color: Color.fromRGBO(84, 176, 243, 1),
                            ),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.documents[index]['comment']
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 14,
                                        color: Colors.black87),
                                  ),
                                  Divider(
                                    height: 20,
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            );
            //return Text(snapshot.data.documents[0]['rating'].toString());
          },
        ),
      ),
    );
  }
}
