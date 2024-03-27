class ItemList {
  String itemId;
  String? name;
  String? details;
  DateTime alteredIn;
  bool? isFinished;
  List<Item>? items;
  DateTime finishedIn;

  ItemList({
    this.itemId = "",
    this.name = "",
    this.details = "",
    this.isFinished = false,
    required this.alteredIn,
    required this.finishedIn,
    this.items = const [],
  });

  // Converte um ItemList em um Map.
  Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'name': name,
        'details': details,
        'alteredIn': alteredIn.toIso8601String(),
        'isFinished': isFinished,
        'items': items?.map((item) => item.toJson()).toList(),
        'finishedIn': finishedIn.toIso8601String(),
      };

  // Cria um ItemList a partir de um Map.
  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        itemId: json['itemId'] ?? "",
        name: json['name'],
        details: json['details'],
        alteredIn: DateTime.parse(json['alteredIn']),
        isFinished: json['isFinished'],
        items: json['items'] != null ? List<Item>.from(json['items'].map((item) => Item.fromJson(item))) : [],
        finishedIn: DateTime.parse(json['finishedIn']),
      );
}

class Item {
  String? id;
  String? name;
  String? quantity;
  String? measurementUnity;
  bool? isChecked;

  Item({
    this.id = "",
    this.name = "",
    this.quantity = "",
    this.measurementUnity = "",
    this.isChecked = false,
  });

  // Converte um Item em um Map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'measurementUnity': measurementUnity,
        'isChecked': isChecked,
      };

  // Cria um Item a partir de um Map.
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        quantity: json['quantity'],
        measurementUnity: json['measurementUnity'],
        isChecked: json['isChecked'],
      );
}
