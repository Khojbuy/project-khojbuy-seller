import 'package:flutter/gestures.dart';
import 'package:khojbuy/Seller/Constants/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:khojbuy/Seller/Screens/homepage_seller.dart';

class DetailsInputSeller extends StatefulWidget {
  @override
  _DetailsInputSellerState createState() => _DetailsInputSellerState();
}

class _DetailsInputSellerState extends State<DetailsInputSeller> {
  AutovalidateMode autovalidateMode = AutovalidateMode.always;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String userName, enterpriseName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(255, 255, 250, 1),
            Color.fromRGBO(245, 245, 245, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: ListView(
            children: <Widget>[
              FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "DETAILS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.longestSide *
                                  0.0016,
                            ),
                            Text(
                              "Enter the details below for registration",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.longestSide * 0.024,
                      ),
                      FormBuilderTextField(
                        attribute: "Shop Name",
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(30),
                          FormBuilderValidators.minLength(5)
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter the name of your Shop ',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          fillColor: Colors.white,
                        ),
                      ),
                      FormBuilderTextField(
                        attribute: "Seller Name",
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(32),
                          FormBuilderValidators.minLength(6)
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter your Name ',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          fillColor: Colors.white,
                        ),
                      ),
                      FormBuilderPhoneField(
                        attribute: "Contact",
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.maxLength(10)
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter your Contact number ',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          fillColor: Colors.white,
                        ),
                      ),
                      FormBuilderFilterChip(
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                        disabledColor: Colors.grey,
                        checkmarkColor: Colors.lightBlueAccent,
                        selectedColor: Color.fromRGBO(41, 74, 171, 0.6),
                        elevation: 6,
                        pressElevation: 12,
                        padding: EdgeInsets.all(8),
                        attribute: "Category",
                        options: category.map((e) => FormBuilderFieldOption(
                              value: e,
                              child: Text(e),
                            )),
                      ),
                      FormBuilderTextField(
                        attribute: "Address",
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6)
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter the address of your shop',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          fillColor: Colors.white,
                        ),
                      ),
                      FormBuilderSwitch(
                          attribute: "Delivery",
                          activeColor: Colors.blueAccent,
                          hoverColor: Colors.lightBlue,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          initialValue: false,
                          label: Text("Do you have home-delivery? ")),
                      SizedBox(height: 15),
                      FormBuilderCheckbox(
                        attribute: 'accept_terms',
                        initialValue: false,
                        leadingInput: true,
                        label: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'I have read and agree to the ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('launch url');
                                  },
                              ),
                            ],
                          ),
                        ),
                        validators: [
                          FormBuilderValidators.requiredTrue(
                            errorText:
                                'You must accept terms and conditions to continue',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  print(_fbKey.currentState.value);
                                } else {
                                  print(_fbKey.currentState.value);
                                  print('validation failed');
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageSeller()),
                                );
                              },
                              elevation: 10,
                              backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                _fbKey.currentState.reset();
                              },
                              elevation: 10,
                              backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
