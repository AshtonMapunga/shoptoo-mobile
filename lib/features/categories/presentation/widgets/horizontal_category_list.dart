import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/app/providers/categories_provider.dart';
import 'package:shoptoo/app/providers/product_provider.dart';
import 'package:shoptoo/features/shop/screen/shop_screen.dart';
import 'package:shoptoo/shared/mocks/horizontal_category_list.dart';
import 'package:shoptoo/shared/themes/colors.dart';

import '../controllers/categories_controller.dart';

class CategoryHorizontalList extends ConsumerStatefulWidget {
  const CategoryHorizontalList({super.key});

  @override
  ConsumerState<CategoryHorizontalList> createState() =>
      _CategoryHorizontalListState();
}

class _CategoryHorizontalListState
    extends ConsumerState<CategoryHorizontalList> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesControllerProvider);

    return categoriesState.when(
      loading: () => const SizedBox(
        height: 70,
        child: Center(child: CategoryShimmerList( itemCount: 6, )),
      ),
      error: (error, _) => SizedBox(
        height: 70,
        child: Center(
          child: Text(
            'Failed to load categories',
            style: GoogleFonts.poppins(fontSize: 13),
          ),
        ),
      ),
      data: (categories) {
        /// 🔹 Add "All" category dynamically
        final allCategories = [
          ShopCategory(
            id: 'all',
            categoryId: null,
            name: 'All',
            icon: Iconsax.category,
            color: Pallete.primaryColor,
          ),
          ...categories.map(_mapBackendCategory),
        ];

        return _buildCategories(allCategories);
      },
    );
  }

  // ============================
  // UI
  // ============================

  Widget _buildCategories(List<ShopCategory> categories) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryItem(categories[index], index);
        },
      ),
    );
  }

  Widget _buildCategoryItem(ShopCategory category, int index) {
    final isSelected = _selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () => _onCategorySelected(category, index),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? category.color : Colors.grey[50],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? category.color : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: 18,
              color: isSelected ? Colors.white : category.color,
            ),
            const SizedBox(width: 6),
            Text(
              category.name,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================
  // ACTIONS
  // ============================

  void _onCategorySelected(ShopCategory category, int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });

    /// 🔹 "All" category
    if (category.categoryId == null) {
      ref.read(productsControllerProvider.notifier).refresh();
    } else {
      ref
          .read(productsByCategoryControllerProvider.notifier)
          .loadCategory(category.categoryId!);
    }
  }

  // ============================
  // HELPERS
  // ============================

  /// 🔹 Map backend category → UI category
  ShopCategory _mapBackendCategory(dynamic backendCategory) {
    return ShopCategory(
      id: backendCategory.id.toString(),
      categoryId: backendCategory.id,
      name: backendCategory.name,
      icon: _iconForCategory(backendCategory.name),
      color: Pallete.primaryColor,
    );
  }

  IconData _iconForCategory(String name) {
    final lower = name.toLowerCase();

    if (lower.contains('electronic')) return Iconsax.mobile;
    if (lower.contains('computer')) return Iconsax.monitor;
    if (lower.contains('furniture')) return Iconsax.element_3;
    if (lower.contains('home')) return Iconsax.home;

    return Iconsax.category;
  }
}
