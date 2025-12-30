
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';
import 'package:shoptoo/features/categories/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call({int page = 1, int perPage = 20}) {
    return repository.getCategories(page: page, perPage: perPage);
  }
}
