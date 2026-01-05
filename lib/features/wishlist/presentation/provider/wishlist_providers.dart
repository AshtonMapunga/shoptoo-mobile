// features/wishlist/presentation/provider/wishlist_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:shoptoo/features/wishlist/data/datasource/wishlist_local_datasource_impl.dart';
import 'package:shoptoo/features/wishlist/presentation/provider/wishlist_notifier.dart';

import '../../data/datasource/wishlist_local_datasource.dart';
import '../../data/model/wishlist_item_model.dart';
import '../../data/repository/wishlist_repository_impl.dart';
import '../../domain/entity/wishlist_item_entity.dart';
import '../../domain/usecase/add_to_wishlist_usecase.dart';
import '../../domain/usecase/get_wishlist_usecase.dart';
import '../../domain/usecase/remove_from_wishlist_usecase.dart';
import '../../domain/usecase/is_in_wishlist_usecase.dart';

final wishlistBoxProvider = Provider<Box<WishlistItemModel>>(
  (ref) => Hive.box<WishlistItemModel>('wishlistBox'),
);

final wishlistLocalDataSourceProvider =
    Provider<WishlistLocalDataSource>(
  (ref) => WishlistLocalDataSourceImpl(
    ref.watch(wishlistBoxProvider),
  ),
);

final wishlistRepositoryProvider = Provider(
  (ref) => WishlistRepositoryImpl(
    ref.watch(wishlistLocalDataSourceProvider),
  ),
);

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<WishlistItemEntity>>(
  (ref) => WishlistNotifier(
    ref.watch(wishlistRepositoryProvider),
  )..loadWishlist(),
);
