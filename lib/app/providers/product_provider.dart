import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shoptoo/features/products/data/datasource/products_local_datasource.dart';
import 'package:shoptoo/features/products/data/datasource/products_local_datasource_impl.dart';
import 'package:shoptoo/features/products/data/datasource/products_remote_datasource.dart';
import 'package:shoptoo/features/products/data/datasource/products_remote_datasource_impl.dart';
import 'package:shoptoo/features/products/data/repositories/products_repository_impl.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/domain/repositories/products_repository.dart';
import 'package:shoptoo/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:shoptoo/features/products/domain/usecases/get_products_usecase.dart';
import 'package:shoptoo/features/products/domain/usecases/search_products_usecase.dart';
import 'package:shoptoo/features/products/presentations/controllers/products_by_category_controller.dart';
import 'package:shoptoo/features/products/presentations/controllers/products_controller.dart';
import 'package:shoptoo/features/products/presentations/controllers/search_products_controller.dart';


final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: dotenv.env['WOOCOMMERCE_BASE_URL']!, // e.g. https://platformex.africa/wp/wp-json/wc/v3
      queryParameters: {
        'consumer_key': dotenv.env['WOOCOMMERCE_CONSUMER_KEY'],
        'consumer_secret': dotenv.env['WOOCOMMERCE_CONSUMER_SECRET'],
      },
    ),
  );
});



final productsRemoteDataSourceProvider =
    Provider<ProductsRemoteDataSource>((ref) {
  return ProductsRemoteDataSourceImpl(ref.read(dioProvider));
});

final productsLocalDataSourceProvider =
    Provider<ProductsLocalDataSource>((ref) {
  return ProductsLocalDataSourceImpl();
});

final productsRepositoryProvider =
    Provider<ProductsRepository>((ref) {
  return ProductsRepositoryImpl(
    ref.read(productsRemoteDataSourceProvider),
    ref.read(productsLocalDataSourceProvider),
  );
});

final getProductsUseCaseProvider =
    Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(ref.read(productsRepositoryProvider));
});

final productsControllerProvider =
    StateNotifierProvider<ProductsController, AsyncValue<List<ProductEntity>>>(
        (ref) {
  return ProductsController(ref.read(getProductsUseCaseProvider));
});


final searchProductsUseCaseProvider = Provider(
  (ref) => SearchProductsUseCase(ref.read(productsRepositoryProvider)),
);

final searchProductsControllerProvider =
    StateNotifierProvider<SearchProductsController,
        AsyncValue<List<ProductEntity>>>(
  (ref) => SearchProductsController(
    ref.read(searchProductsUseCaseProvider),
  ),
);

final getProductsByCategoryUseCaseProvider = Provider(
  (ref) => GetProductsByCategoryUseCase(
    ref.read(productsRepositoryProvider),
  ),
);

final productsByCategoryControllerProvider =
    StateNotifierProvider<ProductsByCategoryController,
        AsyncValue<List<ProductEntity>>>(
  (ref) => ProductsByCategoryController(
    ref.read(getProductsByCategoryUseCaseProvider),
  ),
);