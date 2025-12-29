class ProductEntity {
  final int id;
  final String name;
  final String price;
  final String regularPrice;
  final String image;
  final double rating;
  final int reviewCount;
  final bool featured;
  final bool isNew;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.regularPrice,
    required this.image,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.featured = false,
    this.isNew = false,
  });
}
