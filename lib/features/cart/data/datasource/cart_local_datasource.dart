import '../../domain/entities/cart_item_entity.dart';

class CartMemoryDataSource {
  final List<CartItemEntity> _items = [];

  Future<List<CartItemEntity>> getItems() async {
    return List.from(_items); // return copy
  }

  Future<void> saveItems(List<CartItemEntity> items) async {
    _items
      ..clear()
      ..addAll(items);
  }

  Future<void> clear() async {
    _items.clear();
  }
}
