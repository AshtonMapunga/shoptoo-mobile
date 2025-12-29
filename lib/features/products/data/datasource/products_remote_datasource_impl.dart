import 'package:dio/dio.dart';
import '../models/product_model.dart';
import 'products_remote_datasource.dart';

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;

  ProductsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts({
    required int page,
    required int perPage,
  }) async {
    final params = {
      'per_page': perPage,
      'page': page,
    };

    final response = await dio.get(
      '/products',
      queryParameters: params,
    );

    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  @override
  Future<ProductModel> fetchProductById(int id) async {
    final response = await dio.get('/products/$id');
    return ProductModel.fromJson(response.data);
  }

  @override
Future<List<ProductModel>> searchProducts(
  String query, {
  required int page,
  required int perPage,
}) async {
  final response = await dio.get(
    '/products',
    queryParameters: {
      'search': query,
      'type': 'simple',
      'page': page,
      'per_page': perPage,
    },
  );

  return (response.data as List)
      .map((e) => ProductModel.fromJson(e))
      .toList();
}

  @override
  Future<List<ProductModel>> fetchProductsByCategory({
    required int categoryId,
    required int page,
    required int perPage,
  }) async {
    final response = await dio.get(
      '/products',
      queryParameters: {
        'category': categoryId,
        'type': 'simple',
        'page': page,
        'per_page': perPage,
      },
    );

    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

}
