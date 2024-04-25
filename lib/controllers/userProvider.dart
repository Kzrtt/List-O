import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/models/User.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';
import 'package:quickalert/quickalert.dart';

final userProvider = ChangeNotifierProvider(
  (ref) => UserProvider(
    User(
      name: "",
      email: "",
      photo: "",
      password: "",
      isAdvanced: false,
      itemList: [],
    ),
  ),
);

final class UserProvider extends ValueNotifier<User> {
  UserProvider(User user) : super(user);

  Future<void> convertToAdvanced(User user) async {
    AppPreferences prefs = AppPreferences();

    List<String> userCodedList = await prefs.getStringList(PrefsContants.userList);
    List<User> userDecodedList = List.generate(
      userCodedList.length,
      (index) => User.fromJson(
        jsonDecode(userCodedList[index]),
      ),
    );

    for (var element in userDecodedList) {
      if (element.email == user.email) {
        element.isAdvanced = true;
        value = element;
      }
    }

    List<String> reInsert = List.generate(userDecodedList.length, (index) => jsonEncode(userDecodedList[index].toJson()));

    prefs.setStringList(PrefsContants.userList, reInsert);
    notifyListeners();
  }

  void logout() async {
    AppPreferences prefs = AppPreferences();

    prefs.setString(PrefsContants.signedUser, "");
    value = User(
      name: "",
      email: "",
      photo: "",
      password: "",
      isAdvanced: false,
      itemList: [],
    );

    notifyListeners();
  }

  Future<int> signUp(User user, BuildContext context) async {
    int response = 1;
    AppPreferences prefs = AppPreferences();

    //? Recebendo a atual lista de usuários e adicionando o novo
    List<String> userList = await prefs.getStringList(PrefsContants.userList);

    if (userList.any((element) => User.fromJson(jsonDecode(element)).email == user.email)) {
      response = 0;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Erro no Cadastro',
        text: "Esse email já foi cadstrado...",
      );
    } else {
      userList.add(jsonEncode(user.toJson()));
    }

    prefs.setStringList(PrefsContants.userList, userList);

    //? Atribuindo o usuário cadastrado como usuário atual
    prefs.setString(PrefsContants.signedUser, user.email);
    value = user;
    notifyListeners();

    return response;
  }

  Future<int> login(String email, String password, BuildContext context) async {
    int response = 1;
    AppPreferences prefs = AppPreferences();

    //? Recebendo a lista de usuários e convertendo para uma lista da classe User
    List<String> userCodedList = await prefs.getStringList(PrefsContants.userList);
    List<User> userDecodedList = List.generate(
      userCodedList.length,
      (index) => User.fromJson(
        jsonDecode(userCodedList[index]),
      ),
    );

    //? Atribuindo o usuario com email escolhido como usuário atual
    User user = userDecodedList.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => User(
        name: "",
        email: "",
        photo: "",
        password: "",
        isAdvanced: false,
        itemList: [],
      ),
    );
    if (user.email != "") {
      value = user;
    } else {
      response = 0;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Login Inválido',
        text: "Usuário não encontrado...",
      );
    }
    prefs.setString(PrefsContants.signedUser, email);

    notifyListeners();
    return response;
  }

  Future<int> getUserByEmail(String email) async {
    AppPreferences prefs = AppPreferences();

    //? Recebendo a lista de usuários e convertendo para uma lista da classe User
    List<String> userCodedList = await prefs.getStringList(PrefsContants.userList);
    List<User> userDecodedList = List.generate(
      userCodedList.length,
      (index) => User.fromJson(
        jsonDecode(userCodedList[index]),
      ),
    );

    //? Atribuindo o usuario com email escolhido como usuário atual
    value = userDecodedList.firstWhere((element) => element.email == email);
    prefs.setString(PrefsContants.signedUser, email);

    notifyListeners();
    return 1;
  }
}
