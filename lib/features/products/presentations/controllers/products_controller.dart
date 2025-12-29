import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

class ProductsController
    extends StateNotifier<AsyncValue<List<ProductEntity>>> {
  final GetProductsUseCase getProductsUseCase;

  ProductsController(this.getProductsUseCase)
      : super(const AsyncValue.loading()) {
    fetchNext(); // initial load
  }

  int _page = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  bool get hasMore => _hasMore;

  Future<void> fetchNext() async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    try {
      final products = await getProductsUseCase(page: _page);

      final current = state.asData?.value ?? [];

      if (products.isEmpty) {
        _hasMore = false;
      } else {
        state = AsyncValue.data([...current, ...products]);
        _page++;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;
    state = const AsyncValue.loading();
    await fetchNext();
  }
}
