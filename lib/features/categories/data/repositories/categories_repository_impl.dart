

import 'package:shoptoo/features/categories/data/datasource/categories_remote_datasource.dart';
import 'package:shoptoo/features/categories/data/models/category_model.dart';
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';
import 'package:shoptoo/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remote;

  CategoriesRepositoryImpl(this.remote);

  @override
  Future<List<CategoryEntity>> getCategories({int page = 1, int perPage = 5}) async {
    final categories = await remote.fetchCategories(page: page, perPage: perPage);
    return categories.map(_toEntity).toList();
  }

 CategoryEntity _toEntity(CategoryModel model) => CategoryEntity(
  id: model.id ?? 0, // default to 0 if null
  name: model.name ?? '',
  slug: model.slug ?? '',
  description: model.description ?? '',
  parent: model.parent ?? 0, // default to 0 if no parent
  image: model.image , // <- use src
);

}
