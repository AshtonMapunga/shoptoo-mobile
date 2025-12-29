import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/categories/screens/categories_screen.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/shop/screen/shop_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:shoptoo/shared/widgets/cards/product_card.dart';
import 'package:shoptoo/features/auth/data/productssample.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final Category category;

  const ProductsByCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  final List<ProductEntity> _products = sampleProducts;
  String _selectedSort = 'Popular';
  bool _isGridView = true;

  List<ProductEntity> get _filteredProducts {
    // Filter products by category name
    // Note: You'll need to add a 'category' field to your Product class
    var products = _products.where((product) {
      // Since your Product class doesn't have category field yet,
      // this is a placeholder filter
      return product.name.toLowerCase().contains(
            widget.category.name.toLowerCase().split(' ')[0],
          );
    }).toList();

    // Apply sorting
    switch (_selectedSort) {
      case 'Price: Low to High':
        products.sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => double.parse(b.price).compareTo(double.parse(a.price)));
        break;
      case 'Highest Rated':
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        products.sort((a, b) {
          if (a.isNew && !b.isNew) return -1;
          if (!a.isNew && b.isNew) return 1;
          return a.name.compareTo(b.name);
        });
        break;
      case 'Popular':
      default:
        products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }

    return products;
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
              ...['Popular', 'Newest', 'Price: Low to High', 'Price: High to Low', 'Highest Rated']
                  .map((option) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Category Image Background
                    Positioned.fill(
                      child: Image.network(
                        widget.category.imageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    
                    // Content
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.category.name,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Iconsax.box,
                                size: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.category.productCount} products',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Iconsax.arrow_left,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: innerBoxIsScrolled
                  ? Text(
                      widget.category.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )
                  : null,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    _isGridView ? Iconsax.menu_1 : Iconsax.grid_3,
                    color: innerBoxIsScrolled ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Iconsax.sort,
                    color: innerBoxIsScrolled ? Colors.black : Colors.white,
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
    final products = _filteredProducts;
    
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.box_remove,
              size: 60,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try browsing other categories',
              style: GoogleFonts.poppins(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: _isGridView
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCardComponent(
                  product: product,
                  onTap: () {
                    // Navigate to product details
                  },
                  onAddToCart: () {
                    // Add to cart
                  },
                  onAddToWishlist: () {
                    // Add to wishlist
                  },
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  imageHeight: 110,
                );
              },
            )
          : ListView.separated(
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                      // Product Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image.network(
                          product.image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Product Info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'P${product.price}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Pallete.primaryColor,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.star1,
                                    size: 14,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    product.rating.toStringAsFixed(1),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${product.reviewCount})',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}