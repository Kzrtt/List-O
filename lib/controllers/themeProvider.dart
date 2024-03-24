import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';

final themeProvider = ChangeNotifierProvider(
  (ref) => ThemeProvider(AppPalette.lightColorPalette),
);

final class ThemeProvider extends ValueNotifier<AppPalette> {
  ThemeProvider(AppPalette palette) : super(palette);

  void toggleTheme() {
    value = value == AppPalette.lightColorPalette ? AppPalette.darkColorPalette : AppPalette.lightColorPalette;
  }
}
