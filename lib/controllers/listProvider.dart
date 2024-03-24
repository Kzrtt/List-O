import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/models/List.dart';

final itemListProvider = ChangeNotifierProvider(
  (ref) => ListNotifier(),
);

class ListNotifier extends ValueNotifier<List<ItemList>> {
  ListNotifier() : super([]);

  //? Items Methods
  void checkItemInList(String itemId, String listId) {
    int listIndex = value.indexWhere((list) => list.itemId == listId);

    if (listIndex != -1) {
      // Se encontrou a lista
      ItemList list = value[listIndex];
      for (var i = 0; i < list.items!.length; i++) {
        if (list.items![i].id == itemId) {
          // Corrigido para usar `i` em vez de `listIndex`
          list.items![i].isChecked = true; // Também adicionado toggle para isChecked
          break; // Parar o loop uma vez que o item foi encontrado e modificado
        }
      }
    } else {
      print("Lista não encontrada");
    }

    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  void removeItemInList(String itemId, String listId) {
    // Assume que 'value' é uma referência mutável ao estado atual (como em um StateNotifier).
    int index = value.indexWhere((list) => list.itemId == listId);

    if (index != -1) {
      // Se encontrou a lista
      ItemList list = value[index];
      list.items = list.items!.where((element) => element.id != itemId).toList();
    } else {
      print("erro");
    }

    value = [...value];
    notifyListeners();
  }

  void addItemInList(Item item, String listId) {
    // Assume que 'value' é uma referência mutável ao estado atual (como em um StateNotifier).
    int index = value.indexWhere((list) => list.itemId == listId);

    if (index != -1) {
      // Se encontrou a lista
      ItemList list = value[index];
      list.items = [...list.items!, item]; // Adiciona o novo item
      value[index] = list; // Atualiza a lista no estado
      print(value[index].items!.length);
    } else {
      print("erro");
    }

    // Aqui você deve notificar sobre a alteração do estado, se estiver usando StateNotifier
    // Por exemplo: state = [...value];
    value = [...value];
    notifyListeners();
  }

  //? List Methods
  void updateItem(String listId, ItemList itemList) {
    for (var i = 0; i < value.length; i++) {
      if (value[i].itemId == listId) {
        value[i].name = itemList.name;
        value[i].details = itemList.details;
      }
    }
    value = [...value];
  }

  void addItem(ItemList itemList) {
    String id = "1";
    if (value.isNotEmpty) {
      id = (int.parse(value[value.length - 1].itemId) + 1).toString();
    }

    itemList.itemId = id;
    value = [...value, itemList];
  }

  void removeItem(String itemId) {
    value = value.where((element) => element.itemId != itemId).toList();
  }

  ItemList findList(String listId) {
    return value.singleWhere((element) => element.itemId == listId);
  }
}
