import 'package:prj_list_app/utils/AppController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  late SharedPreferences prefs = AppController.instance.preferences;

  Future<void> startPreferences() async {
    await startPrefs();
  }

  Future<void> startPrefs() async {
    AppController.instance.preferences = await SharedPreferences.getInstance();
  }

  setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future<bool> getBoolItem(String key) async {
    return prefs.getBool(key) ?? false;
  }

  Future<String> getStringItem(String key) async {
    return prefs.getString(key) ?? "";
  }

  Future<List<String>> getStringList(String key) async {
    return prefs.getStringList(key) ?? [];
  }

  Future<bool> removeItem(String key) async {
    return prefs.remove(key);
  }
}
