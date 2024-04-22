import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';

final orientationProvider = ChangeNotifierProvider(
  (ref) => OrientationProvider(AppController.instance.orientation),
);

final class OrientationProvider extends ValueNotifier<String> {
  OrientationProvider(String orientation) : super(orientation);

  void setOrientation(String orientation) {
    value = orientation;
  }

  void toggleOrientation() {
    AppPreferences prefs = AppPreferences();
    if (value == 'list') {
      value = 'grid';
      AppController.instance.orientation = 'grid';
      prefs.setString(PrefsContants.preferredOrientation, 'grid');
    } else {
      value = 'list';
      AppController.instance.orientation = 'list';
      prefs.setString(PrefsContants.preferredOrientation, 'list');
    }
  }
}
