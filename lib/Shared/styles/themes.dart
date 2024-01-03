import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade600),
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: HexColor('333739'),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 20.0,
  ),
);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade400),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan[400],
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20.0,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white),
);
