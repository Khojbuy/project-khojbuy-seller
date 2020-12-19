import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class HomePageSeller extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('SellerData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(
            double.infinity, MediaQuery.of(context).size.longestSide * 0.2),
        child: Container(
          alignment: Alignment(-1, -1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
              ],
              color: Color.fromRGBO(84, 176, 243, 1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.menu_open_rounded,
                                size: 36,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.notifications_active,
                                size: 36,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 10),
                      child: Text(
                        "Khojbuy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide * 0.12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.shortestSide * 0.1,
                  child: Image.asset("assets/images/logo.png"),
                ),
              )
              /*  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.menu_open_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.notifications_active,
                          size: 36,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        }),
                  ],
                ),
              ), */
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      "Khojbuy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  
                ], 
              )*/
            ],
          ),
        ),
      ),
      /*  AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.longestSide * 0.2,
        title: Text(
          "Khojbuy",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        backgroundColor: Color.fromRGBO(84, 176, 243, 0.98),
        leading: IconButton(
            icon: Icon(
              Icons.menu_open_rounded,
              size: 36,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ), */

      body: BlocBuilder<NavigatorBloc, NavigationStates>(
        builder: (context, NavigationStates states) {
          return states as Widget;
        },
      ),
      drawer: Drawer(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(84, 176, 243, 1)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                names(users, context),
                Divider(
                  height: 64,
                  thickness: 0.5,
                  color: Colors.white.withOpacity(0.7),
                  indent: 32,
                  endIndent: 32,
                ),
                MenuItem(Icons.dashboard, "My DashBoard", () {
                  Navigator.of(context).pop();
                  BlocProvider.of<NavigatorBloc>(context)
                      .add(NavigationEvents.DashBoardClickEvent);
                }),
                MenuItem(Icons.person, "My Profile", () {
                  Navigator.of(context).pop();
                  BlocProvider.of<NavigatorBloc>(context)
                      .add(NavigationEvents.ProfileClickEvent);
                }),
                MenuItem(Icons.art_track_rounded, "My Advertisements", () {
                  Navigator.of(context).pop();
                  BlocProvider.of<NavigatorBloc>(context)
                      .add(NavigationEvents.StoryAddEvent);
                }),
                Divider(
                  height: 64,
                  thickness: 0.5,
                  color: Colors.white.withOpacity(0.7),
                  indent: 32,
                  endIndent: 32,
                ),
                MenuItem(Icons.connect_without_contact_rounded, "About Us", () {
                  Navigator.of(context).pop();
                  BlocProvider.of<NavigatorBloc>(context)
                      .add(NavigationEvents.AboutEvent);
                }),
                MenuItem(Icons.feedback_rounded, "Feedback", () async {
                  final Uri feedback = Uri(
                    scheme: 'mailto',
                    path: 'nayakastha2911@gmail.com',
                    //add subject and body here
                  );
                  var url = feedback.toString();
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch';
                  }
                }),
                MenuItem(Icons.exit_to_app, "LOGOUT", () {
                  Navigator.of(context).pop();
                  AuthService().signOut(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.79);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.quadraticBezierTo(size.width * 0.84, size.height * 0.55,
        size.width * 0.66, size.height * 0.39);
    path_0.cubicTo(size.width * 0.60, size.height * 0.29, size.width * 0.54,
        size.height * 0.25, size.width * 0.50, size.height * 0.36);
    path_0.quadraticBezierTo(size.width * 0.42, size.height * 0.57,
        size.width * 0.29, size.height * 0.51);
    path_0.quadraticBezierTo(size.width * 0.17, size.height * 0.50,
        size.width * 0.13, size.height * 0.64);
    path_0.quadraticBezierTo(
        size.width * 0.12, size.height * 0.79, 0, size.height * 0.79);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NavigatorBloc, NavigationStates>(
        builder: (context, NavigationStates states) {
          return states as Widget;
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function ontap;

  MenuItem(this.icon, this.title, this.ontap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 15, top: 15, bottom: 15),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 36,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

FutureBuilder names(CollectionReference users, BuildContext context) {
  return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              ListTile(
                dense: true,
                title: Text(
                  data['ShopName'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'OpenSans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data['Name'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: (data['PhotoURL'] == "url")
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.home_filled,
                          size: 60,
                          color: Colors.white,
                        ),
                        radius: 40,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(
                          data['PhotoURL'],
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          errorBuilder: (context, object, stackTrace) {
                            return Container(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        }
        return Text("Loading");
      });
}
