import 'package:flutter/material.dart';
import 'package:khojbuy/Services/navigator_bloc.dart';

class ProfilePage extends StatefulWidget with NavigationStates {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width - 50, 250),
          child: CustomPaint(
            painter: SCustomPainter(),
            child: Container(
                //color: Color.fromRGBO(41, 74, 171, 0.98),
                ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Text(
            "PROFILE",
            style: TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }
}

class SCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(41, 74, 171, 0.98);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * 0.00, size.height * 0.00);
    path.quadraticBezierTo(
        size.width * 0.00, size.height * 0.00, 0, size.height * 0.12);
    path.cubicTo(size.width * 0.00, size.height * 0.12, size.width * 0.14,
        size.height * 0.25, size.width * 0.14, size.height * 0.32);
    path.cubicTo(size.width * 0.14, size.height * 0.40, size.width * 0.08,
        size.height * 0.52, 0, size.height * 0.52);
    path.quadraticBezierTo(0, size.height * 0.64, 0, size.height * 1.00);
    path.quadraticBezierTo(size.width * 0.23, size.height * 1.00,
        size.width * 0.30, size.height * 1.00);
    path.cubicTo(size.width * 0.31, size.height * 0.88, size.width * 0.42,
        size.height * 0.76, size.width * 0.50, size.height * 0.76);
    path.cubicTo(size.width * 0.58, size.height * 0.76, size.width * 0.69,
        size.height * 0.88, size.width * 0.69, size.height * 1.00);
    path.quadraticBezierTo(size.width * 0.77, size.height * 1.00,
        size.width * 1.00, size.height * 1.00);
    path.lineTo(size.width * 1.00, size.height * 0.00);
    path.lineTo(size.width * 0.00, size.height * 0.00);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
