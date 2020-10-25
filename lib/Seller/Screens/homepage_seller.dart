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
                Icons.menu_open_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              })
        ],
      ),
      body: BlocBuilder<NavigatorBloc, NavigationStates>(
        builder: (context, NavigationStates states) {
          return states as Widget;
        },
      ),
      endDrawer: Drawer(
        elevation: 20,
        child: SingleChildScrollView(
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito'),
                ),
                subtitle: Text(
                  "9994446666",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontSize: 26),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.black12,
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
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            BlocBuilder<NavigatorBloc, NavigationStates>(
              builder: (context, NavigationStates) {
                return NavigationStates as Widget;
              },
            ),
          ],
        ),
      ),
    );
  }
}
