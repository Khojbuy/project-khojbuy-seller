import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Seller/Screens/pages/about_us.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "KHOJBUY",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(41, 74, 171, 0.98),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
        leading: IconButton(
            icon: Icon(
              Icons.menu_open_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
      ),
      body: BlocBuilder<NavigatorBloc, NavigationStates>(
        builder: (context, NavigationStates states) {
          return states as Widget;
        },
      ),
      drawer: Drawer(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(41, 74, 171, 0.98)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              names(users, context),
              Divider(
                height: 64,
                thickness: 0.5,
                color: Colors.white.withOpacity(0.3),
                indent: 32,
                endIndent: 32,
              ),
              MenuItem(Icons.home, "My DashBoard", () {
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
                color: Colors.white.withOpacity(0.3),
                indent: 32,
                endIndent: 32,
              ),
              MenuItem(Icons.connect_without_contact_rounded, "Reach Us", () {
                Navigator.of(context).pop();
                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigationEvents.AboutEvent);
              }),
              MenuItem(Icons.exit_to_app, "LOGOUT", () {
                Navigator.of(context).pop();
                AuthService().signOut(context);
              }),
            ],
          ),
        ),
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
              color: Colors.white54,
              size: 36,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
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
                title: Text(
                  data['ShopName'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito'),
                ),
                leading: (data['PhotoURL'] == " url")
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.white12,
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
