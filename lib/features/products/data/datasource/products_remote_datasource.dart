
import 'package:shoptoo/features/products/data/models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({
    required int page,
    required int perPage,
  });

  Future<ProductModel> fetchProductById(int id);

    Future<List<ProductModel>> fetchProductsByCategory({
    required int categoryId,
    required int page,
    required int perPage,
  });

Future<List<ProductModel>> searchProducts(
    String query, {
    required int page,
    required int perPage,
  });}


  
