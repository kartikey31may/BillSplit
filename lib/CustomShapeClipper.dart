import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    var firstpoint = Offset(size.width*0.5, size.height-20.0);
    var firstpointcontroller = Offset(size.width*0.25, size.height-50.0);

    path.quadraticBezierTo(firstpointcontroller.dx , firstpointcontroller.dy, firstpoint.dx, firstpoint.dy);

    var secondpoint = Offset(size.width,size.height-60.0);
    var secondpointcontroller = Offset(size.width*0.75, size.height+10.0);

    path.quadraticBezierTo(secondpointcontroller.dx , secondpointcontroller.dy, secondpoint.dx, secondpoint.dy);


    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)=> true;
}