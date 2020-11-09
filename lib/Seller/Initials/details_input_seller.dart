import 'package:flutter/material.dart';
import 'package:khojbuy/Constants/categories.dart';
import 'package:khojbuy/Seller/Models/seller.dart';
import 'package:khojbuy/Seller/Services/home_seller.dart';

class DetailsInputSeller extends StatefulWidget {
  @override
  _DetailsInputSellerState createState() => _DetailsInputSellerState();
}

class _DetailsInputSellerState extends State<DetailsInputSeller> {
  final _formKey = GlobalKey<FormState>();

  Seller _seller = new Seller();

  _buildChoiceList() {
    List<Widget> choices = List();
    category.forEach((element) {
      choices.add(Container(
        padding: EdgeInsets.all(12),
        child: ChoiceChip(
          label: Text(element),
          selected: _seller.categories.contains(element),
          onSelected: (selected) {
            setState(() {
              _seller.categories.contains(element)
                  ? _seller.categories.remove(element)
                  : _seller.categories.add(element);
            });
          },
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (val) => _seller.shopName = val,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the required value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Shop Name',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    icon: Icon(
                      Icons.home_rounded,
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                    ),
                  ),
                ),
                TextFormField(
                  onSaved: (val) => _seller.ownerName = val,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the required value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    labelText: 'Owner Name',
                    icon: Icon(
                      Icons.person_pin,
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                    ),
                  ),
                ),
                TextFormField(
                  onSaved: (val) => _seller.email = val,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the required value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'E-mail Address',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    icon: Icon(
                      Icons.email_rounded,
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                    ),
                  ),
                ),
                TextFormField(
                  onSaved: (val) => _seller.contact = val,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the required value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    icon: Icon(
                      Icons.call_rounded,
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                    ),
                  ),
                ),
                Text(
                  "Choose the categories you deal in (max 3) -",
                  softWrap: true,
                  style: TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                ),
                Wrap(
                  children: _buildChoiceList(),
                ),
                SwitchListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      "Do you have home-delivery facility",
                      style:
                          TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    ),
                    activeColor: Color.fromRGBO(41, 74, 171, 0.98),
                    inactiveTrackColor: Colors.blueGrey,
                    value: _seller.deliveryDetails.delivery,
                    onChanged: (val) {
                      _seller.deliveryDetails.delivery = val;
                    }),
                _seller.deliveryDetails.delivery
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              onSaved: (val) =>
                                  _seller.deliveryDetails.minAmt = val,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the required value';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Minimum amount for home delivery',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(41, 74, 171, 0.98)),
                                icon: Icon(
                                  Icons.location_on,
                                  color: Color.fromRGBO(41, 74, 171, 0.98),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                TextFormField(
                  onSaved: (val) => _seller.address.addressLine = val,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the required value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    icon: Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                    ),
                  ),
                ),
                TextFormField(
                  onSaved: (val) => _seller.address.city = val,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the required value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'City',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(41, 74, 171, 0.98)),
                    icon: Icon(
                      Icons.location_city_rounded,
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.longestSide * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: InkWell(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            print(_seller);
                            _formKey.currentState.validate();
                            _formKey.currentState.save();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          elevation: 10,
                          backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                          label: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: InkWell(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            _formKey.currentState.reset();
                          },
                          elevation: 10,
                          backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                          label: Text(
                            "RESET",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
