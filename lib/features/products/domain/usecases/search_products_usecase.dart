
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/repositories/products_repository.dart';

class SearchProductsUseCase {
  final ProductsRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({
    required String query,
    required int page,
    int perPage = 20,
  }) {
    return repository.searchProducts(
      query,
      page: page,
      perPage: perPage,
    );
  }
}
