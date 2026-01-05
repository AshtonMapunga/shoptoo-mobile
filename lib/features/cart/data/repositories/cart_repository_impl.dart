import 'package:shoptoo/features/cart/data/datasource/cart_local_datasource.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_item_hive.dart';

class CartRepositoryImpl implements CartRepository {
  final CartHiveDataSource local;

  CartRepositoryImpl(this.local);

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final items = local.getItems();
    return items.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    final items = local.getItems();
    final index = items.indexWhere((e) => e.productId == item.productId);

    if (index >= 0) {
      final existing = items[index];
      items[index] = CartItemHive(
        productId: existing.productId,
        name: existing.name,
        image: existing.image,
        price: existing.price,
        quantity: existing.quantity + item.quantity,
      );
    } else {
      items.add(CartItemHive.fromEntity(item));
    }

    await local.saveItems(items);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final items = local.getItems()..removeWhere((e) => e.productId == productId);
    await local.saveItems(items);
  }

 @override
Future<void> updateQuantity({required int productId, required int quantity}) async {
  final items = local.getItems();
  final index = items.indexWhere((e) => e.productId == productId);

  if (index >= 0) {
    items[index].quantity = quantity;
    await local.saveItems(items);
  }
}


  @override
  Future<void> clearCart() async {
    await local.clear();
  }
}
