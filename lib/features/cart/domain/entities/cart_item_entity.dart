class CartItemEntity {
  final int productId;
  final String name;
  final String image;
  final String price;
  final int quantity;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  /// 🔹 Derived value
  double get totalPrice =>
      (double.tryParse(price) ?? 0) * quantity;

  /// 🔹 Copy (used for quantity updates)
  CartItemEntity copyWith({
    int? quantity,
  }) {
    return CartItemEntity(
      productId: productId,
      name: name,
      image: image,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  /// ✅ SERIALIZATION (REQUIRED)
  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      productId: json['productId'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}
