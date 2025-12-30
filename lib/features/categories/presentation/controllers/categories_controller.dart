import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';
import 'package:shoptoo/features/categories/domain/usecases/get_categories_usecase.dart';

class CategoriesController extends StateNotifier<AsyncValue<List<CategoryEntity>>> {
  final GetCategoriesUseCase useCase;

  CategoriesController(this.useCase) : super(const AsyncValue.loading()) {
    fetchCategories();
  }

  int _page = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  bool get hasMore => _hasMore;

  Future<void> fetchCategories() async {
    if (_isFetching || !_hasMore) return;
    _isFetching = true;

    try {
      final categories = await useCase(page: _page);
      final current = _page == 1 ? <CategoryEntity>[] : state.asData?.value ?? [];

      if (categories.isEmpty) {
        _hasMore = false;
      } else {
        state = AsyncValue.data([...current, ...categories]);
        _page++;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isFetching = false;
    }
  }

  void refresh() {
    _page = 1;
    _hasMore = true;
    state = const AsyncValue.loading();
    fetchCategories();
  }
}
