import 'package:shoptoo/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:shoptoo/features/wishlist/domain/repository/wishlist_repository.dart';

class AddToWishlistUseCase {
  final WishlistRepository repository;

  AddToWishlistUseCase(this.repository);

  Future<void> call(WishlistItemEntity item) {
    return repository.addToWishlist(item);
  }
}
