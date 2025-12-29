import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/usecases/get_products_by_category_usecase.dart';

class ProductsByCategoryController
    extends StateNotifier<AsyncValue<List<ProductEntity>>> {
  final GetProductsByCategoryUseCase useCase;

  ProductsByCategoryController(this.useCase)
      : super(const AsyncValue.loading());

  int _page = 1;
  bool _hasMore = true;
  bool _isFetching = false;
  int? _categoryId;

  bool get hasMore => _hasMore;

  Future<void> loadCategory(int categoryId) async {
    _categoryId = categoryId;
    _page = 1;
    _hasMore = true;

    state = const AsyncValue.loading();
    await _fetch();
  }

  Future<void> fetchNext() async {
    if (_isFetching || !_hasMore || _categoryId == null) return;
    await _fetch();
  }

  Future<void> _fetch() async {
    _isFetching = true;

    try {
      final products = await useCase(
        categoryId: _categoryId!,
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

  void refresh() {
    if (_categoryId != null) {
      loadCategory(_categoryId!);
    }
  }
}
