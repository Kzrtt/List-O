class ItemList {
  String itemId;
  String? name;
  String? details;
  DateTime alteredIn;
  List<Item>? items;

  ItemList({
    this.itemId = "",
    this.name = "",
    this.details = "",
    required this.alteredIn,
    this.items = const [],
  });
}

class Item {
  String? id;
  String? name;
  String? quantity;
  String? measurementUnity;
  bool? isChecked;

  Item({
    this.name = "",
    this.quantity = "",
    this.measurementUnity = "",
    this.isChecked = false,
  });
}
