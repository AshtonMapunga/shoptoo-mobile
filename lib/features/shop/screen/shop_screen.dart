import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/app/providers/product_provider.dart';
import 'package:shoptoo/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoptoo/features/cart/presentation/providers/cart_providers.dart';
import 'package:shoptoo/features/cart/screens/cart_screen.dart';
import 'package:shoptoo/features/categories/presentation/widgets/horizontal_category_list.dart';
import 'package:shoptoo/features/layouts/screens/main_layout.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/screens/product_details_screen.dart';
import 'package:shoptoo/features/search/screens/search_screen.dart';
import 'package:shoptoo/shared/mocks/mock_product_card.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:shoptoo/shared/widgets/cards/product_card.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  int _selectedCategory = 0;
  String _selectedSort = 'Popular';
  int _cartItemCount = 0;
  final TextEditingController _searchController = TextEditingController();
  late final ScrollController _scrollController;

  final List<ShopCategory> _categories = [
    ShopCategory(
      categoryId: 233, // null for "All" category
      id: '1',
      name: 'All',
      icon: Iconsax.category,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      categoryId: 259,
      id: '2',
      name: 'Electronics',
      icon: Iconsax.mobile,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      categoryId: 260,
      id: '3',
      name: 'Computers',
      icon: Iconsax.monitor,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      categoryId: 261,
      id: '4',
      name: 'Home & Garden',
      icon: Iconsax.home,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      categoryId: 233,
      id: '5',
      name: 'Furniture',
      icon: Iconsax.element_3,
      color: Pallete.primaryColor,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_onScroll);
    
    // Load initial products for the "All" category
    WidgetsBinding.instance.addPostFrameCallback((_) {
  if (_selectedCategory == 0) {
    ref.read(productsControllerProvider.notifier).refresh();
  } else {
    final categoryId = _categories[_selectedCategory].categoryId;
    if (categoryId != null) {
      ref
          .read(productsByCategoryControllerProvider.notifier)
          .loadCategory(categoryId);
    }
  }
});

  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      
      if (_selectedCategory == 0) {
        // Fetch next page for all products
        ref.read(productsControllerProvider.notifier).fetchNext();
      } else {
        final categoryId = _categories[_selectedCategory].categoryId;
        if (categoryId != null) {
          // Fetch next page for category products
          ref.read(productsByCategoryControllerProvider.notifier).fetchNext();
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter & Sort',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sort Options
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sort by',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Popular',
                        'Newest',
                        'Price: Low to High',
                        'Price: High to Low',
                        'Highest Rated',
                      ].map((sortOption) {
                        return FilterChip(
                          label: Text(sortOption),
                          selected: _selectedSort == sortOption,
                          onSelected: (selected) {
                            setState(() {
                              _selectedSort = sortOption;
                            });
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.grey[100],
                          selectedColor: Pallete.primaryColor,
                          checkmarkColor: Colors.white,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Price Range
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Range',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Min',
                              prefixText: 'P',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Max',
                              prefixText: 'P',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSort = 'Popular';
                        });
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Reset All',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Apply',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSearchScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SearchScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }



void _addToCart(ProductEntity product) {
  // Add the product to the cart
 ref.read(cartControllerProvider.notifier).addItem(
  CartItemEntity(
    productId: product.id,
    name: product.name,
    image: product.image,
    price: double.tryParse(product.price) ?? 0.0, // ✅ convert here
    quantity: 1,
  ),
);


  // Show snackbar confirmation
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${product.name} added to cart'),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );
}





  void _addToWishlist(ProductEntity product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to wishlist'),
        backgroundColor: Colors.pink,
      ),
    );
  }

  void _onProductPressed(ProductEntity product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

void _onCategorySelected(int index) {
  setState(() {
    _selectedCategory = index;
  });

  if (index == 0) {
    // Load all products (reset + fetch page 1)
    ref.read(productsControllerProvider.notifier).refresh();
  } else {
    final categoryId = _categories[index].categoryId;
    if (categoryId != null) {
      ref
          .read(productsByCategoryControllerProvider.notifier)
          .loadCategory(categoryId);
    }
  }
}


  List<ProductEntity> _sortProducts(List<ProductEntity> products) {
    final sortedProducts = List<ProductEntity>.from(products);
    
    switch (_selectedSort) {
      case 'Price: Low to High':
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Highest Rated':
        sortedProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        // Assuming products have a createdAt field
        // sortedProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Popular':
      default:
        sortedProducts.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }
    
    return sortedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      initialTabIndex: 1,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInOut,
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Pallete.secondaryColor.withOpacity(0.15),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: -30,
                      right: -30,
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1800),
                        curve: Curves.easeInOut,
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Pallete.secondaryColor.withOpacity(0.1),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: _buildSearchBarWithCart(),
                    ),
                  ],
                ),
              ),
              title: Text(
                'Shop',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.filter, color: Colors.black),
                  onPressed: _showFilters,
                ),
              ],
            ),
            SliverToBoxAdapter(child: CategoryHorizontalList(),),
          ];
        },
        body: _selectedCategory == 0 
            ? _buildAllProducts() 
            : _buildCategoryProducts(),
      ),
      appBar: null,
    );
  }

  Widget _buildSearchBarWithCart() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _navigateToSearchScreen,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      Icons.search,
                      color: Pallete.lightPrimaryTextColor.withOpacity(0.5),
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Search Shoptoo!',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Pallete.lightPrimaryTextColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Pallete.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Iconsax.shopping_bag,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              if (_cartItemCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Text(
                        _cartItemCount > 9 ? '9+' : _cartItemCount.toString(),
                        key: ValueKey<int>(_cartItemCount),
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryItem(_categories[index], index);
        },
      ),
    );
  }

  Widget _buildCategoryItem(ShopCategory category, int index) {
    final isSelected = _selectedCategory == index;
    return GestureDetector(
      onTap: () => _onCategorySelected(index),
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
              color: isSelected ? Colors.white : category.color,
              size: 18,
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

  Widget _buildAllProducts() {
    final productsState = ref.watch(productsControllerProvider);
    final controller = ref.read(productsControllerProvider.notifier);

    return productsState.when(
      loading: () => const Center(child: ProductShimmerLoader(itemCount: 6)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        final sortedProducts = _sortProducts(products);

        return GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: sortedProducts.length + (controller.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= sortedProducts.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final product = sortedProducts[index];
            return ProductCardComponent(
              product: product,
              onTap: () => _onProductPressed(product),
              onAddToCart: () => _addToCart(product),
              onAddToWishlist: () => _addToWishlist(product),
              width: MediaQuery.of(context).size.width / 2 - 24,
              imageHeight: 110,
            );
          },
        );
      },
    );
  }

  Widget _buildCategoryProducts() {
    final state = ref.watch(productsByCategoryControllerProvider);
    final controller = ref.read(productsByCategoryControllerProvider.notifier);

    return state.when(
      loading: () => const Center(child: ProductShimmerLoader(itemCount: 6)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (products) {
        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.box,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No products in this category',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        final sortedProducts = _sortProducts(products);

        return GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: sortedProducts.length + (controller.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= sortedProducts.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final product = sortedProducts[index];
            return ProductCardComponent(
              product: product,
              onTap: () => _onProductPressed(product),
              onAddToCart: () => _addToCart(product),
              onAddToWishlist: () => _addToWishlist(product),
              width: MediaQuery.of(context).size.width / 2 - 24,
              imageHeight: 110,
            );
          },
        );
      },
    );
  }
}

class ShopCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int? categoryId;

  ShopCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.categoryId,
  });
}