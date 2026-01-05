// features/wishlist/domain/usecase/get_wishlist_usecase.dart
import '../entity/wishlist_item_entity.dart';
import '../repository/wishlist_repository.dart';

class GetWishlistUseCase {
  final WishlistRepository repository;

  GetWishlistUseCase(this.repository);

  Future<List<WishlistItemEntity>> call() {
    return repository.getWishlist();
  }
}
