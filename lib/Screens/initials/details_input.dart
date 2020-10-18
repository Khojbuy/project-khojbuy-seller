import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../homepagelayout.dart';

class DetailsInput extends StatefulWidget {
  @override
  _DetailsInputState createState() => _DetailsInputState();
}

List<FormBuilderFieldOption> communities = [
  FormBuilderFieldOption(value: "Electronics", child: Text("Electronics")),
  FormBuilderFieldOption(value: "Clothing", child: Text("Clothing")),
  FormBuilderFieldOption(
      value: "Puja Requirements", child: Text("Puja Requirements")),
  FormBuilderFieldOption(
      value: "Home Essentials", child: Text("Home Essentials")),
  FormBuilderFieldOption(
      value: "Pharmaceuticals", child: Text("Pharmaceuticals")),
  FormBuilderFieldOption(value: "Motor Parts", child: Text("Motor Parts")),
  FormBuilderFieldOption(value: "Footwear", child: Text("Footwear")),
  FormBuilderFieldOption(value: "Grocery", child: Text("Grocery")),
  FormBuilderFieldOption(value: "Stationery", child: Text("Stationery")),
  FormBuilderFieldOption(value: "Hardware", child: Text("Hardware")),
  FormBuilderFieldOption(value: "Furniture", child: Text("Furniture")),
  FormBuilderFieldOption(value: "Gift Shop", child: Text("Gift Shop")),
];

class _DetailsInputState extends State<DetailsInput> {
  AutovalidateMode autovalidateMode = AutovalidateMode.always;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String userName, enterpriseName;
  List<String> category;
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
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                        options: communities),
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
                                    builder: (context) => HomePageLayout()),
                              );
                            },
                            elevation: 10,
                            backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
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
    );
  }
}
