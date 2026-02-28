import 'package:flutter/material.dart';

class TeardropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;
    path.moveTo(w / 2, 0);
    path.quadraticBezierTo(w, 0, w, h /3);
    path.quadraticBezierTo(w, h, w /3, h);

    path.quadraticBezierTo(0, h, 0, h / 2);
    path.quadraticBezierTo(0, 0, w / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
