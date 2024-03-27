import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';

final themeProvider = ChangeNotifierProvider(
  (ref) => ThemeProvider(AppPalette.lightColorPalette),
);

final class ThemeProvider extends ValueNotifier<AppPalette> {
  ThemeProvider(AppPalette palette) : super(palette);

  void selectTheme(int index, BuildContext context, String pop) {
    AppPreferences prefs = AppPreferences();

    switch (index) {
      case 0:
        value = AppPalette.lightColorPalette;
        prefs.setString(PrefsContants.preferredColor, "0");
        break;
      case 1:
        value = AppPalette.darkColorPalette;
        prefs.setString(PrefsContants.preferredColor, "1");
        break;
      case 2:
        value = AppPalette.pinkColorPalette;
        prefs.setString(PrefsContants.preferredColor, "2");
        break;
      case 3:
        value = AppPalette.blueColorPalette;
        prefs.setString(PrefsContants.preferredColor, "3");
        break;
      case 4:
        value = AppPalette.redColorPalette;
        prefs.setString(PrefsContants.preferredColor, "4");
        break;
      default:
    }
    if (pop == 'S') {
      Navigator.of(context).pop();
    }
  }
}
