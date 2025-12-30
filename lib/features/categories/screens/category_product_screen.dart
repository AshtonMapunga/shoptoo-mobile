// features/categories/screens/category_product_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/app/providers/product_provider.dart';
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/products/screens/product_details_screen.dart';
import 'package:shoptoo/shared/mocks/mock_product_card.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:shoptoo/shared/widgets/cards/product_card.dart';

class ProductsByCategoryScreen extends ConsumerStatefulWidget {
  final CategoryEntity category;

  const ProductsByCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  ConsumerState<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState
    extends ConsumerState<ProductsByCategoryScreen> {
  String _selectedSort = 'Popular';
  bool _isGridView = true;
  late ScrollController _scrollController;
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    print("Category ID: ${widget.category.id}");
    print("Category Name: ${widget.category.name}");

    _scrollController = ScrollController()
      ..addListener(_onScroll);

    // Load products for this category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.category.id != null) {
        ref
            .read(productsByCategoryControllerProvider.notifier)
            .loadCategory(widget.category.id!);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      // Fetch next page for category products
      if (widget.category.id != null) {
        ref
            .read(productsByCategoryControllerProvider.notifier)
            .fetchNext();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sort by',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ...[
                'Popular',
                'Newest',
                'Price: Low to High',
                'Price: High to Low',
                'Highest Rated'
              ].map((option) {
                return ListTile(
                  title: Text(
                    option,
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: _selectedSort == option
                      ? Icon(
                          Iconsax.tick_circle,
                          color: Pallete.primaryColor,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedSort = option;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
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

  void _onProductPressed(ProductEntity product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  void _addToCart(ProductEntity product) {
    setState(() {
      _cartItemCount++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        backgroundColor: Pallete.primaryColor,
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart screen
          },
        ),
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

  Color _getCategoryColor() {
    // Generate a consistent color based on category name
    final categoryName = widget.category.name.toLowerCase();
    final colors = {
      'electronics': Color(0xFF6366F1),
      'fashion': Color(0xFFEC4899),
      'home & garden': Color(0xFF10B981),
      'home': Color(0xFF10B981),
      'beauty': Color(0xFFF59E0B),
      'health': Color(0xFFEF4444),
      'sports': Color(0xFF3B82F6),
      'books': Color(0xFF8B5CF6),
      'toys': Color(0xFFF97316),
      'automotive': Color(0xFF64748B),
      'groceries': Color(0xFF14B8A6),
      'furniture': Color(0xFF8B4513),
      'computers': Color(0xFF06B6D4),
      'jewelry': Color(0xFFDC2626),
      'shoes': Color(0xFF7C3AED),
      'bags': Color(0xFF059669),
    };
    
    return colors[categoryName] ?? Pallete.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor();
    
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              expandedHeight: 220,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        categoryColor.withOpacity(0.15),
                        Colors.white,
                      ],
                      stops: [0.3, 0.8],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative elements
                      Positioned(
                        top: -80,
                        right: -80,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: categoryColor.withOpacity(0.08),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -40,
                        right: -40,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: categoryColor.withOpacity(0.05),
                          ),
                        ),
                      ),
                      
                      // Content
                      Positioned(
                        bottom: 30,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                               
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.category.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1E293B),
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (widget.category.description != null)
                                        Text(
                                          widget.category.description!,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF64748B),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: categoryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: categoryColor.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.box,
                                    size: 14,
                                    color: categoryColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final state = ref.watch(
                                          productsByCategoryControllerProvider);
                                      return state.when(
                                        loading: () => Text(
                                          'Loading products...',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: categoryColor,
                                          ),
                                        ),
                                        error: (error, stackTrace) => Text(
                                          'Error loading count',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                        ),
                                        data: (products) => Text(
                                          '${products.length} products',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: categoryColor,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Iconsax.arrow_left,
                    color: Color(0xFF1E293B),
                    size: 20,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: innerBoxIsScrolled
                  ? Text(
                      widget.category.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    )
                  : null,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: innerBoxIsScrolled
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      _isGridView ? Iconsax.menu_1 : Iconsax.grid_3,
                      color: Color(0xFF1E293B),
                      size: 20,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                ),
                IconButton(
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: innerBoxIsScrolled
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Iconsax.sort,
                      color: Color(0xFF1E293B),
                      size: 20,
                    ),
                  ),
                  onPressed: _showSortOptions,
                ),
              ],
            ),
          ];
        },
        body: _buildProductsList(),
      ),
    );
  }

  Widget _buildProductsList() {
    final state = ref.watch(productsByCategoryControllerProvider);
    final controller = ref.read(productsByCategoryControllerProvider.notifier);

    return state.when(
      loading: () => const Center(
        child: ProductShimmerLoader(itemCount: 6),
      ),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.1),
                ),
                child: Icon(
                  Iconsax.warning_2,
                  size: 50,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Failed to load products',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (widget.category.id != null) {
                    controller.loadCategory(widget.category.id!);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getCategoryColor(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Retry',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      data: (products) {
        if (products.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF1F5F9),
                    ),
                    child: Icon(
                      Iconsax.box_remove,
                      size: 64,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'No Products Found',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'There are no products in this category yet. Check back soon!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getCategoryColor(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      'Browse Other Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final sortedProducts = _sortProducts(products);

        if (_isGridView) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
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
        } else {
          // List view layout
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: sortedProducts.length + (controller.hasMore ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index >= sortedProducts.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final product = sortedProducts[index];
              return Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0A1E293B),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                  border: Border.all(
                    color: Color(0xFFF1F5F9),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onProductPressed(product),
                    borderRadius: BorderRadius.circular(16),
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(product.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Product Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E293B),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                const SizedBox(height: 8),
                                
                                Text(
                                  'P${product.price}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: _getCategoryColor(),
                                  ),
                                ),
                                
                                const Spacer(),
                                
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.star1,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      product.rating.toStringAsFixed(1),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '(${product.reviewCount})',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    
                                    const Spacer(),
                                    
                                    if (product.isNew)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF10B981).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Color(0xFF10B981).withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          'NEW',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF10B981),
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}