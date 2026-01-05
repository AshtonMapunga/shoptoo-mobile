import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:shoptoo/features/wishlist/domain/entity/wishlist_item_entity.dart';

class WishlistNotifier extends StateNotifier<List<WishlistItemEntity>> {
  final WishlistRepositoryImpl repository;

  WishlistNotifier(this.repository) : super([]);

  Future<void> loadWishlist() async {
    state = await repository.getWishlist();
  }

  Future<void> toggleWishlist(WishlistItemEntity item) async {
    final exists =
        state.any((e) => e.productId == item.productId);

    if (exists) {
      await repository.removeFromWishlist(item.productId);
    } else {
      await repository.addToWishlist(item);
    }

    await loadWishlist();
  }

  bool isInWishlist(int productId) {
    return state.any((e) => e.productId == productId);
  }
}
