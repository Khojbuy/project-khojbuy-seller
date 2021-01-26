import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileForm extends StatefulWidget {
  Map<String, dynamic> data;
  ProfileForm(this.data);
  @override
  _ProfileFormState createState() => _ProfileFormState(data);
}

class _ProfileFormState extends State<ProfileForm> {
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  Map<String, dynamic> data;
  _ProfileFormState(this.data);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              initialValue: data["Name"],
              decoration: new InputDecoration(
                  labelText: "Name",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  fillColor: Colors.white),
              onSaved: (val) {
                setState(() {
                  data['Name'] = val;
                });
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              autofocus: false,
              initialValue: data['PhoneNo'],
              decoration: new InputDecoration(
                  labelText: "Contact Number",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  fillColor: Colors.white),
              onSaved: (val) {
                setState(() {
                  data['PhoneNo'] = val;
                });
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              minLines: 2,
              maxLines: 4,
              autofocus: false,
              initialValue: data['DealsIn'],
              decoration: new InputDecoration(
                  hintText: "e.g. - Deals in children's books",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "Deals In",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  fillColor: Colors.white),
              onSaved: (val) {
                setState(() {
                  data['DealsIn'] = val;
                });
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter this information';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              autofocus: false,
              initialValue: data['AddressLocation'],
              decoration: new InputDecoration(
                  labelText: "Shop Location ",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  fillColor: Colors.white),
              onSaved: (val) {
                setState(() {
                  data['AddressLocation'] = val;
                });
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Shop Location';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              autofocus: false,
              initialValue: data['AddressCity'],
              decoration: new InputDecoration(
                  labelText: "Shop City",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  fillColor: Colors.white),
              onSaved: (val) {
                setState(() {
                  data['AddressCity'] = val;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CheckboxListTile(
                title: Text(
                  "Home Delivery Facility",
                  style:
                      TextStyle(color: Colors.black87, fontFamily: 'OpenSans'),
                ),
                controlAffinity: ListTileControlAffinity.platform,
                value: data['Delivery'],
                activeColor: Color.fromRGBO(84, 176, 243, 1),
                dense: true,
                onChanged: (val) {
                  setState(() {
                    data['Delivery'] = val;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              minLines: 2,
              maxLines: 4,
              autofocus: false,
              initialValue: data['Other'],
              decoration: new InputDecoration(
                  hintText:
                      "e.g. - Home Delivery only for purchase more than 500 Rs.",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "Other Information",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  fillColor: Colors.white),
              onSaved: (val) {
                setState(() {
                  data['Other'] = val;
                });
              },
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
              child: InkWell(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    keyForm.currentState.validate();
                    keyForm.currentState.save();
                    await FirebaseFirestore.instance
                        .collection('SellerData')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .update(data)
                        .then((value) {
                          print("User Added");
                        })
                        .catchError((error) => print(error))
                        .then((value) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            'Your profile has been updated',
                            style:
                                TextStyle(fontFamily: 'OpenSans', fontSize: 14),
                          )));
                        });
                  },
                  elevation: 10,
                  backgroundColor: Color.fromRGBO(84, 176, 243, 0.6),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Save Data",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'OpenSans',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
