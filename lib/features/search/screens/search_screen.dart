// features/search/view/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/app/providers/product_provider.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/presentations/controllers/search_products_controller.dart';
import 'package:shoptoo/features/products/screens/product_details_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:shoptoo/shared/widgets/cards/product_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late final ScrollController _scrollController;

  String _selectedSort = 'Relevance';
  final List<String> _sortOptions = [
    'Relevance',
    'Price: Low to High',
    'Price: High to Low',
    'Highest Rated',
    'Newest',
    'Popular'
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    
    // Initialize scroll controller for pagination
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
          ref
              .read(searchProductsControllerProvider.notifier)
              .fetchNext();
        }
      });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Start animation when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    ref
        .read(searchProductsControllerProvider.notifier)
        .search(query);
  }

  void _sortProducts(List<ProductEntity> products, String sortOption) {
    switch (sortOption) {
      case 'Price: Low to High':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Highest Rated':
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Popular':
        products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      case 'Newest':
        // Assuming products have a createdAt field
        // products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Relevance':
      default:
        // Keep the original search relevance order
        break;
    }
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort By',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._sortOptions.map((option) => ListTile(
                leading: Icon(
                  Iconsax.radio,
                  color: _selectedSort == option ? Pallete.primaryColor : Colors.grey,
                ),
                title: Text(
                  option,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: _selectedSort == option ? FontWeight.w600 : FontWeight.normal,
                    color: _selectedSort == option ? Pallete.primaryColor : Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedSort = option;
                  });
                  Navigator.pop(context);
                },
              )).toList(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
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
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Pallete.lightPrimaryTextColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search for products...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Pallete.lightPrimaryTextColor.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: _performSearch,
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Iconsax.close_circle, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        _performSearch('');
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Pallete.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: const Icon(Iconsax.sort, color: Colors.white, size: 20),
              onPressed: _showSortOptions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final searchState = ref.watch(searchProductsControllerProvider);
    final controller = ref.read(searchProductsControllerProvider.notifier);

    if (!searchState.isLoading && _searchController.text.isEmpty) {
      return _buildEmptyState();
    }

    return searchState.when(
      loading: () {
        if (searchState.value != null && searchState.value!.isNotEmpty) {
          // Show existing results while loading more
          return _buildResultsGrid(searchState.value!, controller);
        }
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading products',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      data: (products) {
        if (products.isEmpty) {
          return _buildNoResults();
        }

        return _buildResultsGrid(products, controller);
      },
    );
  }

  Widget _buildResultsGrid(List<ProductEntity> products, SearchProductsController controller) {
    // Apply sorting
    final sortedProducts = List<ProductEntity>.from(products);
    _sortProducts(sortedProducts, _selectedSort);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
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
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final product = sortedProducts[index];
                    return ProductCardComponent(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                      onAddToCart: () {
                        // Implement add to cart functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product.name} to cart'),
                          ),
                        );
                      },
                      onAddToWishlist: () {
                        // Implement add to wishlist functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${product.name} to wishlist'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 90,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 20),
              Text(
                'Search for Products',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find your favorite products by name or category',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.search_favorite,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              Text(
                'No Products Found',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try searching with different keywords',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search Header
          SafeArea(
            bottom: false,
            child: _buildSearchHeader(),
          ),
          
          // Search Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }
}