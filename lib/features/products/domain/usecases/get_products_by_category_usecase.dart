import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/repositories/products_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductsRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<List<ProductEntity>> call({
    required int categoryId,
    required int page,
    int perPage = 20,
  }) {
    return repository.getProductsByCategory(
      categoryId: categoryId,
      page: page,
      perPage: perPage,
    );
  }
}
