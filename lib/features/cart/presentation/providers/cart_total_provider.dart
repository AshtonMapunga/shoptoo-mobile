import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoptoo/features/cart/presentation/providers/cart_providers.dart';

final cartTotalProvider = Provider<double>((ref) {
  final cartState = ref.watch(cartControllerProvider);
  return cartState.maybeWhen(
    data: (items) => items.fold(0.0, (sum, item) => sum + item.totalPrice),
    orElse: () => 0.0,
  );
});