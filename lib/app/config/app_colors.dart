import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Color(0xff020202);
  static const Color grey6B = Color(0xFF65676B);
  static const Color trans = Colors.transparent;
  static const Color primary = Color(0xFF108910);
  static const Color lightTextColor = Color(0xFFF3FFD0);
  static const Color primary5FF = Color(0xFFEBF5FF);
  static const Color secondary = Color(0xFF5B5A57);
  static const Color inputBorder = Color(0xFFe6e8ea);
  static const Color dropShadow = Color(0xff000000);
  static const Color inputfield = Color(0xFFffffff);
  static const Color hint = Color(0xFF6C6C6C);
  static const Color grey = Color(0xFF050505);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color red = Color(0xFFFF0019);
  static const Color lightGrey = Color(0xFFB1B5C3);
  static const Color lightWhite = Color(0xffF3F3F5);
  static const Color checkColor = Color(0xFF2A4A45);
  static const Color border = Color(0xFFD3D6DA);
//new

  static const Color containerBackground = Color(0xFF2A4A45);

  //gen
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color progressColor = Colors.greenAccent;
  static const Color errorColor = Colors.red;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xffFFED8F), // Start color
      Color(0xff1E61FF), // End color
    ],
    begin: Alignment.centerRight, // Gradient direction
    end: Alignment.centerLeft,
  );
  static const LinearGradient welcomeGradient = LinearGradient(
    colors: [
      Color(0xffFFD880),
      Color(0xffD09203),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      secondary,
      primary,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient dealGradient = LinearGradient(
    colors: [
      Color(0xFF005EBD),
      Color(0xFFFF5252),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
