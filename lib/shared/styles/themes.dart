import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme =ThemeData(
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),

  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium:  TextStyle(
      fontSize: 14.0,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme =ThemeData(
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium:  TextStyle(
      fontSize: 14.0,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

  ),
);