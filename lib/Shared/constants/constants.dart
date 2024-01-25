import 'package:flutter/material.dart';

import '../styles/themes.dart';

String? token;

List<BottomNavigationBarItem> bottomNavList = [
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart_outlined, color: defaultColor),
    label: "products",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.category, color: defaultColor),
    label: "category",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline, color: defaultColor),
    label: "favorite",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline, color: defaultColor),
    label: "profile",
  )
];
