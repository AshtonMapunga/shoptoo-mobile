import 'package:shoptoo/features/products/data/datasource/products_local_datasource.dart';
import 'package:shoptoo/features/products/data/datasource/products_remote_datasource.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remote;
  final ProductsLocalDataSource local;

  ProductsRepositoryImpl(this.remote, this.local);

  @override
  Future<List<ProductEntity>> getProducts({required int page, required int perPage}) async {
    if (page == 1) {
      final cached = local.getCachedProducts();
      if (cached != null) return cached.map((e) => _toEntity(e)).toList();
    }

    final products = await remote.fetchProducts(page: page, perPage: perPage);
    if (page == 1) await local.cacheProducts(products);

    return products.map((e) => _toEntity(e)).toList();
  }

  @override
  Future<ProductEntity> getProductById(int id) async {
    final product = await remote.fetchProductById(id);
    return _toEntity(product);
  }


  @override
Future<List<ProductEntity>> getProductsByCategory({
  required int categoryId,
  required int page,
  required int perPage,
}) async {
  final products = await remote.fetchProductsByCategory(
    categoryId: categoryId,
    page: page,
    perPage: perPage,
  );

  return products.map(_toEntity).toList();
}

 @override
Future<List<ProductEntity>> searchProducts(
  String query, {
  required int page,
  required int perPage,
}) async {
  final products = await remote.searchProducts(
    query,
    page: page,
    perPage: perPage,
  );

  return products.map(_toEntity).toList();
}

 ProductEntity _toEntity(ProductModel model) => ProductEntity(
      id: model.id ?? 0, // if id is nullable
      name: model.name ?? "Unnamed Product",
      image: (model.images?.isNotEmpty == true
              ? model.images![0].src
              : null) ?? '', // ensures a non-null String
      price: model.price?? "0", // ensure double
      regularPrice: model.regularPrice?? '0.0');// ensure String

}
