import 'package:flutter/material.dart';

class SizeUtils {
  // Screen width and height
  static double screenWidth = 0;
  static double screenHeight = 0;

  // Call this method in your main widget before using rsHeight/rsWidth
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Responsive height (base design height: 812)
  static double rsHeight(double val) {
    return val * screenHeight / 812;
  }

  // Responsive width (base design width: 375)
  static double rsWidth(double val) {
    return val * screenWidth / 375;
  }

  // Optional: responsive font size
  static double rsFont(double val) {
    return val * screenHeight / 812;
  }
}