import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>
    with SingleTickerProviderStateMixin<Sidebar> {
  AnimationController _animationController;

  final _animationDuration = const Duration(milliseconds: 500);
  StreamController isOpenStreamController;
  Stream<bool> isOpenStream;
  StreamSink<bool> isOpenSink;

  @override
  void initState() {
    _animationController =
        AnimationController(value: this, duration: _animationDuration);
    isOpenStreamController = PublishSubject<bool>();
    isOpenStream = isOpenStreamController.stream;
    isOpenSink = isOpenStreamController.sink;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    isOpenStreamController.close();
    isOpenSink.close();
    super.dispose();
  }

  onIconTapped() {
    final animationStatus = _animationController.status;
    final isanimationCompleted = (animationStatus == AnimationStatus.completed);
    if (isanimationCompleted) {
      isOpenSink.add(false);
      _animationController.reverse();
    } else {
      isOpenSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
        initialData: false,
        stream: isOpenStream,
        builder: (context, isOpenAsync) {
          return AnimatedPositioned(
              duration: _animationDuration,
              top: 0,
              bottom: 0,
              left: isOpenAsync.data ? 0 : -screenwidth,
              right: isOpenAsync.data ? 0 : screenwidth - 45,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Color.fromRGBO(41, 74, 171, 0.98),
                      child: Column(
                        children: <Widget>[
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
                                  color: Colors.white60,
                                  fontSize: 26),
                            ),
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.perm_identity,
                                color: Colors.white,
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
                            onIconTapped();
                            BlocProvider.of<NavigatorBloc>(context)
                                .add(NavigationEvents.DashBoardClickEvent);
                          }),
                          MenuItem(Icons.person, "My Profile", () {
                            onIconTapped();
                            BlocProvider.of<NavigatorBloc>(context)
                                .add(NavigationEvents.ProfileClickEvent);
                          }),
                          MenuItem(Icons.shopping_basket, "My Orders", () {
                            onIconTapped();
                            BlocProvider.of<NavigatorBloc>(context)
                                .add(NavigationEvents.OrdersClickEvent);
                          }),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          MenuItem(Icons.exit_to_app, "LOGOUT", () {
                            AuthService().signOut(context);
                          }),
                        ],
                      ),
                    ),
                  )),
                  Align(
                    alignment: Alignment(0, -0.9),
                    child: GestureDetector(
                      onTap: () {
                        onIconTapped();
                      },
                      child: ClipPath(
                        clipper: CustomMenuClipper(),
                        child: Container(
                          width: 35,
                          height: 110,
                          color: Color.fromRGBO(41, 74, 171, 0.98),
                          alignment: Alignment.centerLeft,
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: _animationController,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
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
            Icon(
              icon,
              color: Colors.white54,
              size: 30,
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
