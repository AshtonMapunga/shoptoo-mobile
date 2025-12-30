
import 'package:shoptoo/features/categories/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories({int page = 1, int perPage = 5});
}
