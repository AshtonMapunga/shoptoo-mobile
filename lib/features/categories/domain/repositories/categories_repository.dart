
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<List<CategoryEntity>> getCategories({int page = 1, int perPage = 5});
}
