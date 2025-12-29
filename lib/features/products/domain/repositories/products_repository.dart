
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getProducts({
    required int page,
    required int perPage,
  });

  Future<ProductEntity> getProductById(int id);

    Future<List<ProductEntity>> getProductsByCategory({
    required int categoryId,
    required int page,
    required int perPage,
  });

  Future<List<ProductEntity>> searchProducts(
    String query, {
    required int page,
    required int perPage,
  });}
