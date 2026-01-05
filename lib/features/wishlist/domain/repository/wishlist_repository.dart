// features/wishlist/domain/repository/wishlist_repository.dart
import '../entity/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<List<WishlistItemEntity>> getWishlist();
  Future<void> addToWishlist(WishlistItemEntity item);
  Future<void> removeFromWishlist(int productId);
  Future<bool> isInWishlist(int productId);
}
