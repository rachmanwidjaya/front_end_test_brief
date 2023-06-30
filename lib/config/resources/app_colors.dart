import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._();

  AppColors._();
  static AppColors get instance => _instance;
  final Color primaryColor = const Color.fromRGBO(213, 105, 93, 1);

  //SucsessColor
  final Color sucsessDefault = const Color.fromRGBO(0, 186, 136, 1);
  final Color sucsessDark = const Color.fromRGBO(0, 150, 109, 1);
  final Color sucsessDarkMode = const Color.fromRGBO(52, 234, 185, 1);
  final Color sucsessLight = const Color.fromRGBO(242, 255, 251, 1);
  //Error Color
  final Color errorDefault = const Color.fromRGBO(237, 46, 126, 1);
  final Color errorDark = const Color.fromRGBO(195, 0, 82, 1);
  final Color errorDarkMode = const Color.fromRGBO(255, 132, 183, 1);
  final Color errorLight = const Color.fromRGBO(255, 243, 248, 1);
  //Warning Color
  final Color warningDefault = const Color.fromRGBO(244, 183, 64, 1);
  final Color warningDark = const Color.fromRGBO(48, 98, 0, 1);
  final Color warningDarkMode = const Color.fromRGBO(255, 215, 137, 1);
  //GrayScale Color
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color titleActive = const Color.fromRGBO(5, 5, 5, 1);
  final Color disableInput = const Color.fromRGBO(238, 241, 244, 1);
  final Color bodyText = const Color.fromRGBO(78, 75, 102, 1);
  final Color placeHolder = const Color.fromRGBO(160, 163, 189, 1);
  //DarkMode
  final Color darkModeBackground = const Color.fromRGBO(28, 30, 33, 1);
  final Color darkModeTitle = const Color.fromRGBO(228, 230, 235, 1);
  final Color darkModeBody = const Color.fromRGBO(176, 179, 184, 1);
  final Color darkModeInputBackground = const Color.fromRGBO(58, 59, 60, 1);
}
