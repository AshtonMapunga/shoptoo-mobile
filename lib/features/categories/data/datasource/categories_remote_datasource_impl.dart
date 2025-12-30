import 'package:dio/dio.dart';
import 'categories_remote_datasource.dart';
import '../models/category_model.dart';

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final Dio dio;

  CategoriesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> fetchCategories({int page = 1, int perPage = 5}) async {
    final response = await dio.get(
      '/products/categories',
      queryParameters: {
        'per_page': perPage,
        'page': page,
      },
    );

    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}
