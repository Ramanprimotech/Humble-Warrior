import 'package:flutter/material.dart';

class DonnaDeals extends StatelessWidget {
  const DonnaDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Placeholder() ;
  }
}

Widget banner(double width, double height){
  return  CustomPaint(
  size: Size(width,(height).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
  painter: RPSCustomPainter(),
  );
}

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(0,0);
    path0.lineTo(size.height,size.height);
    path0.lineTo(size.width - size.height,size.height);
    path0.lineTo(size.width,0);
    path0.lineTo(0,0);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
