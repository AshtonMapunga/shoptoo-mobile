import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItemEntity> _cartItems = [];

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return List.from(_cartItems);
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    final index = _cartItems.indexWhere((e) => e.productId == item.productId);

    if (index >= 0) {
      // Increment quantity if item exists
      final existing = _cartItems[index];
      _cartItems[index] = CartItemEntity(
        productId: existing.productId,
        name: existing.name,
        image: existing.image,
        price: existing.price,
        quantity: existing.quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    _cartItems.removeWhere((item) => item.productId == productId);
  }

  @override
  Future<void> updateQuantity({
    required int productId,
    required int quantity,
  }) async {
    final index = _cartItems.indexWhere((e) => e.productId == productId);

    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        final existing = _cartItems[index];
        _cartItems[index] = CartItemEntity(
          productId: existing.productId,
          name: existing.name,
          image: existing.image,
          price: existing.price,
          quantity: quantity,
        );
      }
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
  }
}
