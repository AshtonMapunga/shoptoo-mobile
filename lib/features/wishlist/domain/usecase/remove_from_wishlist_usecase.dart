import 'package:shoptoo/features/wishlist/domain/repository/wishlist_repository.dart';

class RemoveFromWishlistUseCase {
  final WishlistRepository repository;

  RemoveFromWishlistUseCase(this.repository);

  Future<void> call(int productId) {
    return repository.removeFromWishlist(productId);
  }
}
