import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String currentTheme = '';

ThemeData lightTheme() {
  return ThemeData(
      primaryIconTheme: IconThemeData(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      scaffoldBackgroundColor: const Color.fromRGBO(235, 236, 240, 1),
      accentColor: const Color.fromRGBO(115, 148, 190, .8),
      shadowColor: const Color.fromRGBO(166, 171, 189, 1),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color.fromRGBO(235, 236, 240, 1),
          focusElevation: 12,
          elevation: 10),
      errorColor: Colors.red,
      hintColor: Colors.grey,
      textTheme: TextTheme(
          headline5: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.w700),
          headline6: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          subtitle1: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
          subtitle2: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          )));
}

ThemeData darkTheme() {
  return ThemeData(
      applyElevationOverlayColor: true,
      scaffoldBackgroundColor: const Color.fromRGBO(42, 45, 50, 1),
      accentColor: const Color.fromRGBO(124, 127, 139, 1),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          focusElevation: 12,
          elevation: 10,
          backgroundColor: const Color.fromRGBO(58, 60, 70, 1)),
      hintColor: Colors.white70,
      errorColor: Colors.deepOrangeAccent,
      textTheme: TextTheme(
          headline5: const TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w700),
          headline6: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          subtitle1: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          subtitle2: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          )),

    iconTheme: IconThemeData(color: Colors.white),

  );
}

class LightShadow {
  static const Color primaryShadow = Color.fromRGBO(250, 251, 255, 1);
  static const Color secondaryShadow = Color.fromRGBO(166, 171, 189, 1);
}

class DarkShadow {
  static const Color primaryShadow = Color.fromRGBO(48, 52, 58, 1);
  static const Color secondaryShadow = Color.fromRGBO(36, 38, 43, 1);
}

Future<void> setThemePreference({String currentValue}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  currentTheme = currentValue;
  print(currentTheme);
  preferences.setString('theme', currentValue);
}

Future<void> getThemePreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString('theme') == null) {
    currentTheme = 'light';
  } else {
    currentTheme = preferences.getString('theme');
  }
}

const urlPattern =
    r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)";
RegExp urlValidate = RegExp(urlPattern, caseSensitive: false);

const lightThemeBorder = <Color>[
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(186, 190, 204, 1)
];
