// ignore_for_file: unused_element

import 'dart:ffi';

import 'package:flutter/material.dart';

enum AppPalette {
  lightColorPalette(
    backgroundColor: Color.fromRGBO(207, 207, 207, 1),
    titleColor: Color.fromRGBO(76, 163, 68, 1),
    subTitleColor: Color.fromRGBO(157, 177, 155, 1),
    buttonColor: Color.fromRGBO(126, 233, 117, 1),
    tileColor: Color.fromRGBO(228, 255, 225, 1),
    icon: Icons.brightness_3_outlined,
    homePageImage: "assets/lightHomePage.svg",
    shoppingListImage: "assets/lightShoppingList.svg",
  ),
  darkColorPalette(
    backgroundColor: Color.fromRGBO(207, 207, 207, 1),
    titleColor: Color.fromRGBO(130, 59, 180, 1),
    subTitleColor: Color.fromRGBO(178, 142, 203, 1),
    buttonColor: Color.fromRGBO(170, 102, 217, 1),
    tileColor: Color.fromRGBO(201, 165, 226, 1),
    icon: Icons.light_mode_outlined,
    homePageImage: "assets/darkHomePage.svg",
    shoppingListImage: "assets/darkShoppingList.svg",
  ),
  pinkColorPalette(
    backgroundColor: Color.fromRGBO(207, 207, 207, 1),
    titleColor: Color.fromRGBO(217, 44, 148, 1),
    subTitleColor: Color.fromRGBO(208, 134, 178, 1),
    buttonColor: Color.fromRGBO(235, 95, 179, 1),
    tileColor: Color.fromRGBO(239, 163, 209, 1),
    icon: Icons.light_mode_outlined,
    homePageImage: "assets/pinkHomePage.svg",
    shoppingListImage: "assets/darkShoppingList.svg",
  ),
  blueColorPalette(
    backgroundColor: Color.fromRGBO(207, 207, 207, 1),
    titleColor: Color.fromRGBO(72, 90, 248, 1),
    subTitleColor: Color.fromRGBO(126, 135, 214, 1),
    buttonColor: Color.fromRGBO(112, 123, 223, 1),
    tileColor: Color.fromRGBO(150, 159, 240, 1),
    icon: Icons.light_mode_outlined,
    homePageImage: "assets/blueHomePage.svg",
    shoppingListImage: "assets/darkShoppingList.svg",
  ),
  redColorPalette(
    backgroundColor: Color.fromRGBO(207, 207, 207, 1),
    titleColor: Color.fromRGBO(239, 72, 81, 1),
    subTitleColor: Color.fromRGBO(201, 126, 129, 1),
    buttonColor: Color.fromRGBO(241, 115, 122, 1),
    tileColor: Color.fromRGBO(234, 165, 168, 1),
    icon: Icons.light_mode_outlined,
    homePageImage: "assets/redHomePage.svg",
    shoppingListImage: "assets/darkShoppingList.svg",
  ),
  disabledColor(
    backgroundColor: Color.fromRGBO(207, 207, 207, 1),
    titleColor: Color.fromRGBO(172, 160, 180, 1),
    subTitleColor: Color.fromRGBO(194, 186, 186, 1),
    buttonColor: Color.fromRGBO(198, 186, 206, 1),
    tileColor: Color.fromRGBO(214, 214, 214, 1),
    icon: Icons.light_mode_outlined,
  );

  const AppPalette({
    required this.backgroundColor,
    required this.titleColor,
    required this.subTitleColor,
    required this.buttonColor,
    required this.tileColor,
    required this.icon,
    this.homePageImage = "",
    this.shoppingListImage = "",
  });

  final Color backgroundColor;
  final Color titleColor;
  final Color subTitleColor;
  final Color buttonColor;
  final Color tileColor;
  final IconData icon;
  final String? homePageImage;
  final String? shoppingListImage;

  String get name {
    switch (this) {
      case AppPalette.lightColorPalette:
        return "lightColorPalette";
      case AppPalette.darkColorPalette:
        return "darkColorPalette";
      case AppPalette.pinkColorPalette:
        return "pinkColorPalette";
      case AppPalette.blueColorPalette:
        return "blueColorPalette";
      case AppPalette.redColorPalette:
        return "redColorPalette";
      case AppPalette.disabledColor:
        return "disabledColor";
    }
  }

  // Static method to retrieve an enum value from a string identifier
  static AppPalette fromName(String name) {
    switch (name) {
      case "lightColorPalette":
        return AppPalette.lightColorPalette;
      case "darkColorPalette":
        return AppPalette.darkColorPalette;
      case "pinkColorPalette":
        return AppPalette.pinkColorPalette;
      case "blueColorPalette":
        return AppPalette.blueColorPalette;
      case "redColorPalette":
        return AppPalette.redColorPalette;
      case "disabledColor":
        return AppPalette.disabledColor;
      default:
        return AppPalette.darkColorPalette;
    }
  }
}
