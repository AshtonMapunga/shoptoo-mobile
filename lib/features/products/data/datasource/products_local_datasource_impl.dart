import 'package:shoptoo/features/products/data/models/product_model.dart';

import 'products_local_datasource.dart';

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  List<ProductModel>? _cache;

  @override
  List<ProductModel>? getCachedProducts() => _cache;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    _cache = products;
  }
}
