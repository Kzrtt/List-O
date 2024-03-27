import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';
import 'package:quickalert/quickalert.dart';

final itemListProvider = ChangeNotifierProvider(
  (ref) => ListNotifier(),
);

class ListNotifier extends ValueNotifier<List<ItemList>> {
  ListNotifier() : super([]);

  AppPreferences prefs = AppPreferences();
  bool hasFinishedList = false;

  //? Items Methods
  Future<void> recheckItemInList(String itemId, String listId) async {
    List<ItemList> prefsItemList = await getPrefsItemList();
    int listIndex = value.indexWhere((list) => list.itemId == listId);

    if (listIndex != -1) {
      // Se encontrou a lista
      ItemList prefsList = prefsItemList[listIndex];
      ItemList list = value[listIndex];
      for (var i = 0; i < list.items!.length; i++) {
        if (list.items![i].id == itemId) {
          // Corrigido para usar `i` em vez de `listIndex`
          prefsList.items![i].isChecked = false;
          list.items![i].isChecked = false; // Também adicionado toggle para isChecked
          prefsList.isFinished = false;
          list.isFinished = false;
          setPrefsItemList(prefsItemList);
          break; // Parar o loop uma vez que o item foi encontrado e modificado
        }
      }
    } else {
      print("Lista não encontrada");
    }

    notifyListeners();
  }

  Future<void> checkItemInList(String itemId, String listId) async {
    List<ItemList> prefsItemList = await getPrefsItemList();
    int listIndex = value.indexWhere((list) => list.itemId == listId);

    if (listIndex != -1) {
      // Se encontrou a lista
      ItemList prefsList = prefsItemList[listIndex];
      ItemList list = value[listIndex];
      bool isAllChecked = true;
      for (var i = 0; i < list.items!.length; i++) {
        if (list.items![i].id == itemId) {
          // Corrigido para usar `i` em vez de `listIndex`
          prefsList.items![i].isChecked = true;
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
        prefsList.isFinished = true;
        list.finishedIn = DateTime.now();
        prefsList.finishedIn = DateTime.now();
      }
    } else {
      print("Lista não encontrada");
    }

    setPrefsItemList(prefsItemList);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  Future<void> removeItemInList(String itemId, String listId) async {
    // Assume que 'value' é uma referência mutável ao estado atual (como em um StateNotifier).
    List<ItemList> prefsItemList = await getPrefsItemList();
    int index = value.indexWhere((list) => list.itemId == listId);

    if (index != -1) {
      // Se encontrou a lista
      ItemList prefsList = prefsItemList[index];
      ItemList list = value[index];
      list.items = list.items!.where((element) => element.id != itemId).toList();
      prefsList.items = prefsList.items!.where((element) => element.id != itemId).toList();
      setPrefsItemList(prefsItemList);
    } else {
      print("erro");
    }

    value = [...value];
    notifyListeners();
  }

  Future<void> addItemInList(Item item, String listId) async {
    // Assume que 'value' é uma referência mutável ao estado atual (como em um StateNotifier).
    List<ItemList> prefsItemList = await getPrefsItemList();
    int index = value.indexWhere((list) => list.itemId == listId);

    if (index != -1) {
      // Se encontrou a lista
      ItemList list = value[index];
      list.items = [...list.items!, item]; // Adiciona o novo item
      value[index] = list; // Atualiza a lista no estado

      ItemList prefsList = prefsItemList[index];
      prefsList.items = [...prefsList.items!, item];
      prefsItemList[index] = prefsList;
      setPrefsItemList(prefsItemList);
    } else {
      print("erro");
    }

    // Aqui você deve notificar sobre a alteração do estado, se estiver usando StateNotifier
    // Por exemplo: state = [...value];
    value = [...value];
    notifyListeners();
  }

  //? List Methods
  void setItems(List<ItemList> list) {
    value = [...list];
    notifyListeners();
  }

  Future<void> updateItem(String listId, ItemList itemList) async {
    List<ItemList> prefsItemList = await getPrefsItemList();
    for (var i = 0; i < value.length; i++) {
      if (value[i].itemId == listId) {
        value[i].name = itemList.name;
        value[i].details = itemList.details;
      }
      if (prefsItemList[i].itemId == listId) {
        prefsItemList[i].name = itemList.name;
        prefsItemList[i].details = itemList.details;
        prefsItemList[i].alteredIn = DateTime.now();
      }
    }
    setPrefsItemList(prefsItemList);
    value = [...value];
  }

  Future<void> addItem(ItemList itemList) async {
    List<ItemList> prefsItemList = await getPrefsItemList();

    String id = "1";
    if (value.isNotEmpty) {
      id = (int.parse(value[value.length - 1].itemId) + 1).toString();
    }

    itemList.itemId = id;
    prefsItemList.add(itemList);
    setPrefsItemList(prefsItemList);
    value = [...value, itemList];
  }

  Future<void> removeItem(String itemId, BuildContext context) async {
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
        List<ItemList> prefsItemList = await getPrefsItemList();
        value = value.where((element) => element.itemId != itemId).toList();
        prefsItemList = prefsItemList.where((element) => element.itemId != itemId).toList();
        setPrefsItemList(prefsItemList);
      },
      onCancelBtnTap: () => Navigator.of(context).pop(),
    );
  }

  ItemList findList(String listId) {
    return value.singleWhere((element) => element.itemId == listId);
  }

  Future<List<ItemList>> getPrefsItemList() async {
    List<String> items = await prefs.getStringList(PrefsContants.itemList);
    return items.map((e) => ItemList.fromJson(jsonDecode(e))).toList();
  }

  Future<void> setPrefsItemList(List<ItemList> newItemList) async {
    List<String> list = newItemList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.removeItem(PrefsContants.itemList);
    await prefs.setStringList(PrefsContants.itemList, list);
  }
}
