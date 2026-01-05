import 'package:shoptoo/features/wishlist/domain/repository/wishlist_repository.dart';

class IsInWishlistUseCase {
  final WishlistRepository repository;

  IsInWishlistUseCase(this.repository);

  Future<bool> call(int productId) {
    return repository.isInWishlist(productId);
  }
}
