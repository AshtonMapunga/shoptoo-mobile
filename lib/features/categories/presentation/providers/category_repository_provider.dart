import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/datasource/categories_remote_datasource_impl.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../domain/repositories/categories_repository.dart';

/// Dio provider (reuse if you already have a global one)
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://platformex.africa/wp/wp-json/wc/v3',
      queryParameters: {
        'consumer_key': 'ck_6d16b304a63963834c4daaeebef9d9e5e788c7b4',
        'consumer_secret': 'cs_210fd18dd61b1749069a888346b833b7bf3e2ee2',
      },
    ),
  );
});

final categoriesRemoteDataSourceProvider = Provider(
  (ref) => CategoriesRemoteDataSourceImpl(ref.read(dioProvider)),
);

final categoriesRepositoryProvider = Provider<CategoriesRepository>(
  (ref) => CategoriesRepositoryImpl(
    ref.read(categoriesRemoteDataSourceProvider),
  ),
);
