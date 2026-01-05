import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_quantity_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';

class CartController extends StateNotifier<AsyncValue<List<CartItemEntity>>> {
  final AddToCartUseCase addToCart;
  final GetCartItemsUseCase getCartItems;
  final RemoveFromCartUseCase removeFromCart;
  final UpdateQuantityUseCase updateQuantity;
  final ClearCartUseCase clearCartUseCase;

  CartController({
    required this.addToCart,
    required this.getCartItems,
    required this.removeFromCart,
    required this.updateQuantity,
    required this.clearCartUseCase,
  }) : super(const AsyncValue.loading()) {
    loadCart();
  }

  Future<void> loadCart() async {
    try {
      final items = await getCartItems();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addItem(CartItemEntity item) async {
    await addToCart(item);
    await loadCart();
  }

  Future<void> removeItem(int productId) async {
    await removeFromCart(productId);
    await loadCart();
  }

  Future<void> updateItemQuantity({required int productId, required int quantity}) async {
    if (quantity <= 0) {
      await removeItem(productId);
    } else {
      await updateQuantity(productId: productId, quantity: quantity);
      await loadCart();
    }
  }

  Future<void> clearCart() async {
    await clearCartUseCase();
    state = const AsyncValue.data([]);
  }
}
