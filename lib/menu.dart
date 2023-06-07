import 'package:flutter/material.dart';
import 'main.dart';
import 'mainDriver.dart';

class MenuItem{
  final String text;
  //final IconData icon;
  const MenuItem({
    required this.text,
    //required this.icon
  });
}
class MenuItems{
  static const List<MenuItem> items = [
    itemLogout,
  ];
  static const itemLogout = MenuItem(
    text: 'Sign Out',
    //icon: Icon.logout,
  );
}