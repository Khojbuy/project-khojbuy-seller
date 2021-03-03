import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuEdit extends StatefulWidget {
  final List<dynamic> menu;
  MenuEdit(this.menu);
  @override
  _MenuEditState createState() => _MenuEditState(menu);
}

class _MenuEditState extends State<MenuEdit> {
  List<dynamic> menu;
  _MenuEditState(this.menu);
  final formkey = new GlobalKey<FormState>();
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  String itemName, detail = '', price = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          title: Text(
            "Edit Your Product List",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color.fromRGBO(84, 176, 243, 1).withOpacity(0.2)),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text(
                          'Add the item details',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10.0),
                                  child: TextFormField(
                                    initialValue: itemName,
                                    decoration: InputDecoration(
                                        hintText: 'Item Name',
                                        isDense: true,
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'OpenSans',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600)),
                                    onChanged: (value) {
                                      setState(() {
                                        itemName = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10.0),
                                  child: TextFormField(
                                    initialValue: price,
                                    decoration: InputDecoration(
                                        hintText: 'Item Price',
                                        isDense: true,
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'OpenSans',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600)),
                                    onChanged: (value) {
                                      setState(() {
                                        price = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 250,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: TextFormField(
                                initialValue: detail,
                                decoration: InputDecoration(
                                    hintText: 'Item Detail',
                                    isDense: true,
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'OpenSans',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600)),
                                onChanged: (value) {
                                  setState(() {
                                    detail = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  formkey.currentState.save();
                                  if (itemName != '') {
                                    print(itemName);
                                    menu.add({
                                      'ItemName': itemName,
                                      'Detail': detail,
                                      'Price': price
                                    });
                                    formkey.currentState.reset();
                                  }
                                  return;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  child: Text(
                    'Here are the existing items in your product list',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                ),
                ListView.builder(
                    itemCount: menu.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              menu[index]['ItemName'],
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14,
                                  color: Colors.black87),
                            ),
                            Text(
                              '₹ ' + menu[index]['Price'],
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 12,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          menu[index]['Detail'],
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.black54),
                        ),
                        trailing: SizedBox(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                menu.removeAt(index);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    }),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                        color:
                            Color.fromRGBO(84, 176, 243, 1).withOpacity(0.95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          "SAVE CHANGES",
                          style: TextStyle(
                              fontFamily: 'OpenSans', color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('SellerData')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .update({'Menu': menu}).then((value) {
                              scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Your catalouge is being updated'),
                                    CircularProgressIndicator()
                                  ],
                                ),
                              ));
                            });
                          });
                          Navigator.of(context).pop();
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
