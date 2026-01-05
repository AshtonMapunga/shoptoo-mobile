// features/wishlist/data/repository/wishlist_repository_impl.dart
import '../../domain/entity/wishlist_item_entity.dart';
import '../../domain/repository/wishlist_repository.dart';
import '../datasource/wishlist_local_datasource.dart';
import '../model/wishlist_item_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;

  WishlistRepositoryImpl(this.localDataSource);

  @override
  Future<void> addToWishlist(WishlistItemEntity item) async {
    await localDataSource.add(WishlistItemModel.fromEntity(item));
  }

  @override
  Future<List<WishlistItemEntity>> getWishlist() async {
    return localDataSource
        .getWishlist()
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<void> removeFromWishlist(int productId) async {
    await localDataSource.remove(productId);
  }

  @override
  Future<bool> isInWishlist(int productId) async {
    return localDataSource.exists(productId);
  }
}
