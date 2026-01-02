import 'package:shoptoo/features/cart/data/datasource/cart_local_datasource.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartMemoryDataSource local;

  CartRepositoryImpl(this.local);

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return local.getItems();
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    final items = await local.getItems();
    final index = items.indexWhere((e) => e.productId == item.productId);

    if (index >= 0) {
      final existing = items[index];
      items[index] = CartItemEntity(
        productId: existing.productId,
        name: existing.name,
        image: existing.image,
        price: existing.price,
        quantity: existing.quantity + item.quantity,
      );
    } else {
      items.add(item);
    }

    await local.saveItems(items);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final items = await local.getItems();
    items.removeWhere((item) => item.productId == productId);
    await local.saveItems(items);
  }

  @override
  Future<void> updateQuantity({required int productId, required int quantity}) async {
    final items = await local.getItems();
    final index = items.indexWhere((e) => e.productId == productId);

    if (index >= 0) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        final existing = items[index];
        items[index] = CartItemEntity(
          productId: existing.productId,
          name: existing.name,
          image: existing.image,
          price: existing.price,
          quantity: quantity,
        );
      }
    }

    await local.saveItems(items);
  }

  @override
  Future<void> clearCart() async {
    await local.clear();
  }
}
