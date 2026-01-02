import 'package:shoptoo/features/cart/domain/entities/cart_item_entity.dart';

import 'cart_local_datasource.dart';
class CartMemoryDataSourceImpl implements CartMemoryDataSource {
  final List<CartItemEntity> _cache = [];

  @override
  List<CartItemEntity> getItems() {
    return List.unmodifiable(_cache);
  }

  @override
  void saveItems(List<CartItemEntity> items) {
    _cache
      ..clear()
      ..addAll(items);
  }

  @override
  void clear() {
    _cache.clear();
  }
}

