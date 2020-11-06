import 'package:list_generator/app/models/item.dart';

class ItemList {
  String name;
  final bool favorite;
  final Map<String, dynamic> items;

  ItemList(this.name, this.favorite, this.items);
}
