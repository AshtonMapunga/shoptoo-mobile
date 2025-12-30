import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';
import 'package:shoptoo/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:shoptoo/features/categories/presentation/controllers/categories_controller.dart';
import 'package:shoptoo/features/categories/presentation/providers/category_repository_provider.dart';

final getCategoriesUseCaseProvider = Provider(
  (ref) => GetCategoriesUseCase(
    ref.read(categoriesRepositoryProvider),
  ),
);

final categoriesControllerProvider =
    StateNotifierProvider<CategoriesController, AsyncValue<List<CategoryEntity>>>(
  (ref) => CategoriesController(ref.read(getCategoriesUseCaseProvider)),
);
