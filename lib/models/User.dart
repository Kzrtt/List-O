import 'package:prj_list_app/models/List.dart';

class User {
  String name;
  String photo;
  String email;
  String password;
  bool isAdvanced;
  List<ItemList> itemList;

  User({
    required this.name,
    required this.email,
    required this.photo,
    required this.password,
    required this.isAdvanced,
    required this.itemList,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'photo': photo,
        'password': password,
        'isAdvanced': isAdvanced,
        'itemList': itemList.map((item) => item.toJson()).toList(),
      };

  factory User.fromJson(Map<String, dynamic> json) {
    var listFromJson = json['itemList'] as List;
    List<ItemList> itemList = listFromJson.map((item) => ItemList.fromJson(item)).toList();
    return User(
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      password: json['password'],
      isAdvanced: json['isAdvanced'],
      itemList: itemList,
    );
  }
}
