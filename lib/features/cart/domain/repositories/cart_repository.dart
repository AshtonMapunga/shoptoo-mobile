import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCartItems();
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity({required int productId, required int quantity});
  Future<void> clearCart();
}
