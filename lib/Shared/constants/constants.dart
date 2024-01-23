import 'package:flutter/material.dart';

String? token;

const List<BottomNavigationBarItem> bottomNavList = [
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart_outlined, color: Colors.blueGrey),
    label: "products",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.category, color: Colors.blueGrey),
    label: "category",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite_outline, color: Colors.blueGrey),
    label: "favorite",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings, color: Colors.blueGrey),
    label: "settings",
  )
];
