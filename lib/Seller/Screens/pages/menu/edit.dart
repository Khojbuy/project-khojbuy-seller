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
  String itemName, detail, price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(84, 176, 243, 1),
          title: Text(
            "Edit Your Catalouge",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.longestSide * 0.2,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color.fromRGBO(84, 176, 243, 1).withOpacity(0.2)),
                child: Form(
                  key: formkey,
                  child: Container(
                    height: MediaQuery.of(context).size.longestSide * 0.3,
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
                          children: [
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: itemName,
                                    decoration: InputDecoration(
                                        hintText: 'Item Name',
                                        hintStyle: TextStyle(
                                            fontFamily: 'OpenSans',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600)),
                                    onChanged: (value) {
                                      setState(() {
                                        itemName = value;
                                      });
                                    },
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        initialValue: detail,
                                        decoration: InputDecoration(
                                            hintText: 'Details',
                                            hintStyle: TextStyle(
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        initialValue: price,
                                        decoration: InputDecoration(
                                            hintText: 'Quantity',
                                            hintStyle: TextStyle(
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
                                )),
                          ],
                        ),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              "ADD",
                              style: TextStyle(fontFamily: 'OpenSans'),
                            ),
                            onPressed: () {
                              setState(() {
                                formkey.currentState.save();

                                return;
                              });
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
