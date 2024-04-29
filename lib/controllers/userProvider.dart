import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:prj_list_app/models/User.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';
import 'package:quickalert/quickalert.dart';

final userProvider = ChangeNotifierProvider(
  (ref) => UserProvider(
    User(
      id: 0,
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

  //? Manipulação das Listas do Usuário
  Future<void> removeItemInList(String itemId, String listId) async {
    // Assume que 'value' é uma referência mutável ao estado atual (como em um StateNotifier).
    List<ItemList> userDecodedList = value.itemList;
    int index = userDecodedList.indexWhere((list) => list.itemId == listId);

    if (index != -1) {
      // Se encontrou a lista
      ItemList list = userDecodedList[index];
      list.items = list.items!.where((element) => element.id != itemId).toList();
      list.alteredIn = DateTime.now();
    } else {
      print("erro");
    }

    await updateUser(value);
    notifyListeners();
  }

  Future<void> recheckItemInList(String itemId, String listId) async {
    List<ItemList> userCodedList = value.itemList;
    int listIndex = userCodedList.indexWhere((list) => list.itemId == listId);

    if (listIndex != -1) {
      // Se encontrou a lista
      ItemList list = userCodedList[listIndex];
      for (var i = 0; i < list.items!.length; i++) {
        if (list.items![i].id == itemId) {
          // Corrigido para usar `i` em vez de `listIndex`
          list.items![i].isChecked = false; // Também adicionado toggle para isChecked
          list.isFinished = false;
          list.alteredIn = DateTime.now();
          break; // Parar o loop uma vez que o item foi encontrado e modificado
        }
      }
    } else {
      print("Lista não encontrada");
    }

    await updateUser(value);
    notifyListeners();
  }

  Future<void> checkItemInList(String itemId, String listId) async {
    List<ItemList> userDecodedList = value.itemList;
    int listIndex = userDecodedList.indexWhere((list) => list.itemId == listId);

    if (listIndex != -1) {
      // Se encontrou a lista
      ItemList list = userDecodedList[listIndex];
      bool isAllChecked = true;
      for (var i = 0; i < list.items!.length; i++) {
        if (list.items![i].id == itemId) {
          // Corrigido para usar `i` em vez de `listIndex`
          list.items![i].isChecked = true; // Também adicionado toggle para isChecked
        }
      }
      for (var i = 0; i < list.items!.length; i++) {
        if (!list.items![i].isChecked!) {
          isAllChecked = false;
        }
      }
      if (isAllChecked) {
        list.isFinished = true;
        list.finishedIn = DateTime.now();
      }
      list.alteredIn = DateTime.now();
    } else {
      print("Lista não encontrada");
    }

    await updateUser(value);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  Future<void> addItemInList(Item item, String listId) async {
    // Assume que 'value' é uma referência mutável ao estado atual (como em um StateNotifier).
    List<ItemList> userDecodedList = value.itemList;
    int index = userDecodedList.indexWhere((list) => list.itemId == listId);

    if (index != -1) {
      // Se encontrou a lista
      ItemList list = userDecodedList[index];
      list.items = [...list.items!, item]; // Adiciona o novo item
      list.alteredIn = DateTime.now();
      userDecodedList[index] = list; // Atualiza a lista no estado
      value.itemList = userDecodedList;
    } else {
      print("erro");
    }

    // Aqui você deve notificar sobre a alteração do estado, se estiver usando StateNotifier
    // Por exemplo: state = [...value];
    await updateUser(value);
    notifyListeners();
  }

  ItemList getList(String listId) {
    List<ItemList> lists = value.itemList;
    for (var i = 0; i < lists.length; i++) {
      if (lists[i].itemId == listId) {
        return lists[i];
      }
    }
    return ItemList(alteredIn: DateTime.now(), finishedIn: DateTime.now());
  }

  Future<void> updateList(String listId, ItemList updatedList) async {
    List<ItemList> userItemList = value.itemList;
    for (var i = 0; i < userItemList.length; i++) {
      if (userItemList[i].itemId == listId) {
        userItemList[i].name = updatedList.name;
        userItemList[i].details = updatedList.details;
        userItemList[i].alteredIn = DateTime.now();
      }
    }
    value.itemList = userItemList;
    await updateUser(value);
    notifyListeners();
  }

  Future<void> removeList(String listId, BuildContext context) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      confirmBtnText: "Deletar",
      cancelBtnText: "Cancelar",
      title: "Tem Certeza!?",
      text: "Deseja mesmo remover essa lista?",
      confirmBtnColor: AppPalette.redColorPalette.buttonColor,
      confirmBtnTextStyle: TextStyle(
        color: AppPalette.redColorPalette.titleColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      showConfirmBtn: true,
      onConfirmBtnTap: () async {
        List<ItemList> userItemList = value.itemList;
        userItemList = userItemList.where((element) => element.itemId != listId).toList();
        value.itemList = userItemList;
        await updateUser(value);
        notifyListeners();
        Navigator.of(context).pop();
      },
      onCancelBtnTap: () => Navigator.of(context).pop(),
    );
  }

  Future<void> addList(ItemList list) async {
    List<ItemList> userItemList = value.itemList;

    String id = "1";
    if (userItemList.isNotEmpty) {
      id = (int.parse(userItemList[userItemList.length - 1].itemId) + 1).toString();
    }

    list.itemId = id;
    userItemList.add(list);
    value.itemList = userItemList;
    await updateUser(value);
    notifyListeners();
  }

  //? Manipulação do Usuário
  Future<void> addUser(User user) async {
    AppPreferences prefs = AppPreferences();

    List<User> userDecodedList = await getUserList();
    List<String> userList = [];

    for (var element in userDecodedList) {
      userList.add(jsonEncode(element.toJson()));
    }
    userList.add(jsonEncode(user.toJson()));
    prefs.setStringList(PrefsContants.userList, userList);
  }

  Future<void> updateUser(User user) async {
    AppPreferences prefs = AppPreferences();

    List<User> userDecodedList = await getUserList();
    List<String> userList = [];

    for (var element in userDecodedList) {
      if (element.id == user.id) {
        element = user;
      }
      userList.add(jsonEncode(element.toJson()));
    }

    prefs.setStringList(PrefsContants.userList, userList);
  }

  void toggleOrientation() {
    print("teste");
    if (value.orientation == 'list') {
      value.orientation = 'grid';
    } else {
      value.orientation = 'list';
    }

    // Chama a função para atualizar o usuário com as novas informações
    updateUser(value);
    notifyListeners();
  }

  void selectTheme(int index, BuildContext context, String pop) {
    AppPreferences prefs = AppPreferences();

    switch (index) {
      case 0:
        value.palette = AppPalette.lightColorPalette;
        prefs.setString(PrefsContants.preferredColor, "0");
        break;
      case 1:
        value.palette = AppPalette.darkColorPalette;
        prefs.setString(PrefsContants.preferredColor, "1");
        break;
      case 2:
        value.palette = AppPalette.pinkColorPalette;
        prefs.setString(PrefsContants.preferredColor, "2");
        break;
      case 3:
        value.palette = AppPalette.blueColorPalette;
        prefs.setString(PrefsContants.preferredColor, "3");
        break;
      case 4:
        value.palette = AppPalette.redColorPalette;
        prefs.setString(PrefsContants.preferredColor, "4");
        break;
      default:
    }

    updateUser(value);

    if (pop == 'S') {
      if (value.isAdvanced) {
        GoRouter.of(context).pushReplacement("/advHomeScreen");
      } else {
        GoRouter.of(context).pushReplacement("/homeScreen");
      }
    }
  }

  Future<List<User>> getUserList() async {
    AppPreferences prefs = AppPreferences();
    List<String> userCodedList = await prefs.getStringList(PrefsContants.userList);
    return List<User>.generate(
      userCodedList.length,
      (index) => User.fromJson(
        jsonDecode(userCodedList[index]),
      ),
    );
  }

  Future<void> convertToAdvanced(User user) async {
    AppPreferences prefs = AppPreferences();

    List<User> userDecodedList = await getUserList();

    for (var element in userDecodedList) {
      if (element.id == user.id) {
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
      id: 0,
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
    user.palette = AppPalette.darkColorPalette;
    user.orientation = "list";

    //? Recebendo a atual lista de usuários e adicionando o novo
    List<User> userDecodedList = await getUserList();

    if (userDecodedList.any((element) => element.email == user.email)) {
      response = 0;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Erro no Cadastro',
        text: "Esse email já foi cadstrado...",
      );
    } else {
      user.id = userDecodedList.length + 1;
    }

    await addUser(user);

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
    List<User> userDecodedList = await getUserList();

    //? Atribuindo o usuario com email escolhido como usuário atual
    User user = userDecodedList.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => User(
        id: 0,
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
    List<User> userDecodedList = await getUserList();

    //? Atribuindo o usuario com email escolhido como usuário atual
    value = userDecodedList.firstWhere((element) => element.email == email);
    prefs.setString(PrefsContants.signedUser, email);

    notifyListeners();
    return 1;
  }
}
