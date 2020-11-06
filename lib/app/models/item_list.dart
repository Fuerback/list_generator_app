import 'package:list_generator/app/models/item.dart';

class ItemList {
  String name;
  final bool favorite;
  final List<Item> items;

  ItemList(this.name, this.favorite, this.items);
}
