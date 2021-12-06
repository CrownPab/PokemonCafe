import 'package:pokemon_cafe/data/menu_item.dart';

class OrderItem {
  MenuItem menuItem;

  final int size;
  final int? sugar, cream;
  final String notes;

  OrderItem(this.menuItem, this.size, this.sugar, this.cream, this.notes);
}
