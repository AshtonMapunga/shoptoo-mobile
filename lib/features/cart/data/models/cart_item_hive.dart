import 'package:hive/hive.dart';
import 'package:shoptoo/features/cart/domain/entities/cart_item_entity.dart';

part 'cart_item_hive.g.dart';

@HiveType(typeId: 0)
class CartItemHive extends HiveObject {
  @HiveField(0)
  int productId;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  double price;

  @HiveField(4)
  int quantity;

  CartItemHive({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  CartItemEntity toEntity() => CartItemEntity(
        productId: productId,
        name: name,
        image: image,
        price: price,
        quantity: quantity,
      );

  factory CartItemHive.fromEntity(CartItemEntity entity) => CartItemHive(
        productId: entity.productId,
        name: entity.name,
        image: entity.image,
        price: entity.price,
        quantity: entity.quantity,
      );
}
