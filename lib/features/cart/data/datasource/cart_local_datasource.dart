import 'package:hive/hive.dart';
import '../models/cart_item_hive.dart';

class CartHiveDataSource {
  final Box<CartItemHive> box;

  CartHiveDataSource(this.box);

  List<CartItemHive> getItems() => box.values.toList();

  Future<void> saveItems(List<CartItemHive> items) async {
    await box.clear();
    for (var item in items) {
      await box.put(item.productId, item);
    }
  }

  Future<void> clear() async => await box.clear();
}
