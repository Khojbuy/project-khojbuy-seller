import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'package:khojbuy/Seller/Services/navigator_bloc.dart';

class HomePageSeller extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
              SizedBox(
                height: 100,
              ),
              ListTile(
                title: Text(
                  "John Doe",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito'),
                ),
                subtitle: Text(
                  "9994446666",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      color: Colors.white54,
                      fontSize: 26),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white12,
                  ),
                  radius: 40,
                ),
              ),
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
              MenuItem(Icons.question_answer_outlined, "FAQs", () {
                Navigator.of(context).pop();
                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigationEvents.FaqClickEvent);
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
