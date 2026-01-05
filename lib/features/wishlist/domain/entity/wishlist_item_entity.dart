// features/wishlist/domain/entity/wishlist_item_entity.dart
import 'package:equatable/equatable.dart';

class WishlistItemEntity extends Equatable {
  final int productId;
  final String name;
  final String image;
  final String price;

  const WishlistItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  List<Object?> get props => [productId];
}
