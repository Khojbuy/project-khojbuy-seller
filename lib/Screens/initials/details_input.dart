import 'package:flutter/material.dart';
import '../homepagelayout.dart';

class DetailsInput extends StatefulWidget {
  @override
  _DetailsInputState createState() => _DetailsInputState();
}

class _DetailsInputState extends State<DetailsInput> {
  String userName, enterpriseName;
  List<String> category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 255, 250, 1),
              Color.fromRGBO(245, 245, 245, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
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
                      height: 4,
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
                height: 60,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter your Name',
                  labelText: 'Name',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  fillColor: Colors.white,
                ),
                validator: (userName) {
                  if (userName.isEmpty) {
                    return 'Name is required';
                  }
                  if (userName.length < 3) {
                    return 'Name is too short';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                autofocus: true,
                onSaved: (userName) {
                  setState(() {
                    this.userName = userName;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Enter your Enterprise Name',
                  labelText: 'Enterprise Name',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  fillColor: Colors.white,
                ),
                validator: (userName) {
                  if (userName.isEmpty) {
                    return 'Enterprise Name is required';
                  }
                  if (userName.length < 3) {
                    return 'Name is too short';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                autofocus: true,
                onSaved: (enterpriseName) {
                  setState(() {
                    this.enterpriseName = enterpriseName;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  child: InkWell(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageLayout()),
                        );
                      },
                      elevation: 10,
                      backgroundColor: Color.fromRGBO(41, 74, 171, 0.6),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
