import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/models/List.dart';

class User {
  int id;
  String name;
  String photo;
  String email;
  String password;
  bool isAdvanced;
  List<ItemList> itemList;
  AppPalette? palette;
  String? orientation;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.password,
    required this.isAdvanced,
    required this.itemList,
    this.palette = AppPalette.darkColorPalette,
    this.orientation = 'list',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photo': photo,
        'password': password,
        'isAdvanced': isAdvanced,
        'itemList': itemList.map((item) => item.toJson()).toList(),
        'palette': palette != null ? palette!.name : 'darkColorPalette',
        'orientation': orientation,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    var listFromJson = json['itemList'] as List;
    List<ItemList> itemList = listFromJson.map((item) => ItemList.fromJson(item)).toList();
    return User(
      id: json['id'] ?? 0, // Assume default as 0 if null
      name: json['name'] ?? '', // Default to an empty string if null
      email: json['email'] ?? '',
      photo: json['photo'] ?? '',
      password: json['password'] ?? '',
      isAdvanced: json['isAdvanced'] ?? false, // Default to false if null
      itemList: itemList,
      palette: json['palette'] != null ? AppPalette.fromName(json['palette']) : null, // Already handled
      orientation: json['orientation'] ?? 'list',
    );
  }
}
