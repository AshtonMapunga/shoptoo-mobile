
import 'package:shoptoo/features/products/data/models/product_model.dart';

abstract class ProductsLocalDataSource {
  List<ProductModel>? getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}
