import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/usecases/search_products_usecase.dart';

class SearchProductsController
    extends StateNotifier<AsyncValue<List<ProductEntity>>> {
  final SearchProductsUseCase searchProductsUseCase;

  SearchProductsController(this.searchProductsUseCase)
      : super(const AsyncValue.data([]));

  int _page = 1;
  bool _hasMore = true;
  bool _isFetching = false;
  String _currentQuery = '';

  bool get hasMore => _hasMore;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    _currentQuery = query;
    _page = 1;
    _hasMore = true;

    state = const AsyncValue.loading();
    await _fetch();
  }

  Future<void> fetchNext() async {
    if (_isFetching || !_hasMore || _currentQuery.isEmpty) return;
    await _fetch();
  }

  Future<void> _fetch() async {
    _isFetching = true;

    try {
      final products = await searchProductsUseCase(
        query: _currentQuery,
        page: _page,
      );

      final current = _page == 1
          ? <ProductEntity>[]
          : state.asData?.value ?? [];

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

  void clear() {
    _currentQuery = '';
    _page = 1;
    _hasMore = false;
    state = const AsyncValue.data([]);
  }
}
