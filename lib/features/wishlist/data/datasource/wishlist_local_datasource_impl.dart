import 'package:hive/hive.dart';
import 'package:shoptoo/features/wishlist/data/datasource/wishlist_local_datasource.dart';
import 'package:shoptoo/features/wishlist/data/model/wishlist_item_model.dart';

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final Box<WishlistItemModel> box;

  WishlistLocalDataSourceImpl(this.box);

  @override
  List<WishlistItemModel> getWishlist() {
    return box.values.toList();
  }

  @override
  Future<void> add(WishlistItemModel item) async {
    await box.put(item.productId, item);
  }

  @override
  Future<void> remove(int productId) async {
    await box.delete(productId);
  }

  @override
  bool exists(int productId) {
    return box.containsKey(productId);
  }
}
