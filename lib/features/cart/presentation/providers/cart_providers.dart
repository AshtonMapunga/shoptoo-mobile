import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:shoptoo/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:shoptoo/features/cart/domain/entities/cart_item_entity.dart';
import '../../data/models/cart_item_hive.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_quantity_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../controllers/cart_controller.dart';

final cartHiveDataSourceProvider = Provider<CartHiveDataSource>((ref) {
  final box = Hive.box<CartItemHive>('cartBox');
  return CartHiveDataSource(box);
});

final cartRepositoryProvider = Provider((ref) => CartRepositoryImpl(ref.read(cartHiveDataSourceProvider)));

final addToCartUseCaseProvider = Provider((ref) => AddToCartUseCase(ref.read(cartRepositoryProvider)));
final getCartItemsUseCaseProvider = Provider((ref) => GetCartItemsUseCase(ref.read(cartRepositoryProvider)));
final removeFromCartUseCaseProvider = Provider((ref) => RemoveFromCartUseCase(ref.read(cartRepositoryProvider)));
final updateQuantityUseCaseProvider = Provider((ref) => UpdateQuantityUseCase(ref.read(cartRepositoryProvider)));
final clearCartUseCaseProvider = Provider((ref) => ClearCartUseCase(ref.read(cartRepositoryProvider)));

final cartControllerProvider = StateNotifierProvider<CartController, AsyncValue<List<CartItemEntity>>>(
  (ref) => CartController(
    addToCart: ref.read(addToCartUseCaseProvider),
    getCartItems: ref.read(getCartItemsUseCaseProvider),
    removeFromCart: ref.read(removeFromCartUseCaseProvider),
    updateQuantity: ref.read(updateQuantityUseCaseProvider),
    clearCartUseCase: ref.read(clearCartUseCaseProvider),
  ),
);

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartControllerProvider).asData?.value ?? [];
  return items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
});
