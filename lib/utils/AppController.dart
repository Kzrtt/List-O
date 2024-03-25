import 'package:flutter/cupertino.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController with ChangeNotifier {
  static AppController? _instance;

  //? Variaveis do App
  List<ItemList> lists = [];

  late SharedPreferences preferences;

  AppController._internal();

  static get instance {
    _instance ??= AppController._internal();
    return _instance;
  }
}
