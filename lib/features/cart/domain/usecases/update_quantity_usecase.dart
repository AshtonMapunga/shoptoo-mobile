import '../repositories/cart_repository.dart';

class UpdateQuantityUseCase {
  final CartRepository repository;

  UpdateQuantityUseCase(this.repository);

  Future<void> call({required int productId, required int quantity}) async {
    await repository.updateQuantity(productId: productId, quantity: quantity);
  }
}
