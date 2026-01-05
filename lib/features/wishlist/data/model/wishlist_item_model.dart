import 'package:hive/hive.dart';
import '../../domain/entity/wishlist_item_entity.dart';

part 'wishlist_item_model.g.dart';

@HiveType(typeId: 1)
class WishlistItemModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String price;

  WishlistItemModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
  });

  factory WishlistItemModel.fromEntity(WishlistItemEntity entity) {
    return WishlistItemModel(
      productId: entity.productId,
      name: entity.name,
      image: entity.image,
      price: entity.price,
    );
  }

  WishlistItemEntity toEntity() {
    return WishlistItemEntity(
      productId: productId,
      name: name,
      image: image,
      price: price,
    );
  }
}
