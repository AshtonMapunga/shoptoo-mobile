import 'package:shoptoo/features/categories/data/models/category_model.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final int? parent;
  final Image? image;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.parent,
    this.image,
  });
}
