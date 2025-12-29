
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({
    required int page,
    int perPage = 20,
  }) {
    return repository.getProducts(
      page: page,
      perPage: perPage,
    );
  }
}
