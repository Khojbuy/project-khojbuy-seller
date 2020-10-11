import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Services/authservice.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';
import 'package:khojbuy/Screens/pages/about_us.dart';
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
        AnimationController(vsync: this, duration: _animationDuration);
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
    final screenwidth = MediaQuery.of(context).size.shortestSide;
    final screenheight = MediaQuery.of(context).size.longestSide;
    return StreamBuilder<bool>(
        initialData: false,
        stream: isOpenStream,
        builder: (context, isOpenAsync) {
          return AnimatedPositioned(
              duration: _animationDuration,
              top: 0,
              bottom: 0,
              left: isOpenAsync.data ? 0 : -screenwidth,
              right: isOpenAsync.data ? 0 : screenwidth - 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      height: screenheight,
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
                          MenuItem(Icons.question_answer_outlined, "FAQs", () {
                            onIconTapped();
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
                          MenuItem(
                              Icons.connect_without_contact_rounded, "Reach Us",
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactInfo()),
                            );
                          }),
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
                          width: 45,
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
    //print(size.width / size.height);

    Path path = Path();
    path.moveTo(size.width * 0.00, size.height * 1.00);
    path.lineTo(0, size.height * 0.00);
    path.quadraticBezierTo(size.width * 0.93, size.height * 0.24,
        size.width * 0.93, size.height * 0.47);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.73,
        size.width * 0.00, size.height * 1.00);
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
