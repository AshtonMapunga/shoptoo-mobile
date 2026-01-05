class CartItemEntity {
  final int productId;
  final String name;
  final String image;
  final double price; // already double
  final int quantity;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  /// 🔹 Derived value
  double get totalPrice => price * quantity;

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

  /// ✅ Serialization
  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      productId: json['productId'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] is String)
          ? double.tryParse(json['price']) ?? 0
          : (json['price'] as num).toDouble(),
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
