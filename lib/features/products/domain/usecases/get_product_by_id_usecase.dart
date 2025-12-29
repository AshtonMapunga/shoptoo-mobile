
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/repositories/products_repository.dart';

class GetProductByIdUseCase {
  final ProductsRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<ProductEntity> call(int id) {
    return repository.getProductById(id);
  }
}
