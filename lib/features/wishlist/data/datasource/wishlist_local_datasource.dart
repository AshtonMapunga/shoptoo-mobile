import 'package:hive/hive.dart';
import '../model/wishlist_item_model.dart';

abstract class WishlistLocalDataSource {
  List<WishlistItemModel> getWishlist();
  Future<void> add(WishlistItemModel item);
  Future<void> remove(int productId);
  bool exists(int productId);
}
