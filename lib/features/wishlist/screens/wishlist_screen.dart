import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/cart/domain/entities/cart_item_entity.dart';
import 'package:shoptoo/features/cart/presentation/providers/cart_providers.dart';
import 'package:shoptoo/features/layouts/screens/main_layout.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/wishlist/domain/entity/wishlist_item_entity.dart';
import 'package:shoptoo/features/wishlist/presentation/provider/wishlist_providers.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  bool _showOnlyInStock = false;
  String _selectedSort = 'Recently Added';


  List<WishlistItemEntity> _filteredItems(List<WishlistItemEntity> wishlist) {
    var items = List<WishlistItemEntity>.from(wishlist);


    
    
    // Sort items
    switch (_selectedSort) {
      case 'Price: Low to High':
        items.sort((a, b) {
          final priceA = double.tryParse(a.price) ?? 0;
          final priceB = double.tryParse(b.price) ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'Price: High to Low':
        items.sort((a, b) {
          final priceA = double.tryParse(a.price) ?? 0;
          final priceB = double.tryParse(b.price) ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'Recently Added':
      default:
        // Keep original order (most recent first)
        break;
    }
    
    return items;
  }

  void _removeFromWishlist(int index, List<WishlistItemEntity> filteredItems) {
    final item = filteredItems[index];
    ref.read(wishlistProvider.notifier).toggleWishlist(item);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed from wishlist'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref.read(wishlistProvider.notifier).toggleWishlist(item);
          },
        ),
      ),
    );
  }

  void _addToCart(WishlistItemEntity item) {
  // Add the product to the cart
 ref.read(cartControllerProvider.notifier).addItem(
  CartItemEntity(
    productId: item.productId,
    name: item.name,
    image: item.image,
    price: double.tryParse(item.price) ?? 0.0, 
    quantity: 1,
  ),
);


  // Show snackbar confirmation
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${item.name} added to cart'),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );
}

  

  void _moveToCart(WishlistItemEntity item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} moved to cart'),
        backgroundColor: Pallete.primaryColor,
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort Items',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Iconsax.close_circle),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Sort Options
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(5),
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
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Recently Added',
                        'Price: Low to High',
                        'Price: High to Low',
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
            ],
          ),
        ),
      ),
    );
  }

  void _showEmptyWishlist(List<WishlistItemEntity> wishlist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Wishlist',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to remove all items from your wishlist?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              for (var item in wishlist) {
                ref.read(wishlistProvider.notifier).toggleWishlist(item);
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Clear All',
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = ref.watch(wishlistProvider);
    // CALL THE FUNCTION HERE - pass wishlist as parameter
    final filteredItems = _filteredItems(wishlist);

    return MainLayout(
      initialTabIndex: 2,
      body: Stack(
        children: [
          // Background animated circles
          _buildBackgroundCircles(),
          
          // Main content
          CustomScrollView(
            slivers: [
              // App Bar with animation
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                floating: true,
                expandedHeight: 70,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Animated half circles
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
                      // Secondary circle
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
                    ],
                  ),
                ),
                title: AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    'My Wishlist',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Iconsax.arrow_left, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  if (wishlist.isNotEmpty)
                    IconButton(
                      icon: Icon(Iconsax.filter, color: Colors.black),
                      onPressed: _showFilters,
                    ),
                  if (wishlist.isNotEmpty)
                    IconButton(
                      icon: Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () => _showEmptyWishlist(wishlist),
                    ),
                ],
              ),

              // Content based on wishlist state
              if (wishlist.isEmpty)
                _buildEmptyWishlistContent()
              else
                _buildWishlistContent(filteredItems), // Now passing List<WishlistItemEntity>, not the function
            ],
          ),
        ],
      ), appBar: null,
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        // Top right animated half circle
        Positioned(
          top: -100,
          right: -100,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.15),
                  ),
                ),
              );
            },
          ),
        ),
        // Secondary top right circle
        Positioned(
          top: -80,
          right: -80,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
        // Bottom left animated half circle
        Positioned(
          bottom: -100,
          left: -100,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.15),
                  ),
                ),
              );
            },
          ),
        ),
        // Secondary bottom left circle
        Positioned(
          bottom: -80,
          left: -80,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  SliverList _buildWishlistContent(List<WishlistItemEntity> filteredItems) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // Summary Bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: Colors.grey[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${filteredItems.length} ${filteredItems.length == 1 ? 'item' : 'items'}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        // Wishlist Items
        ...filteredItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _buildWishlistItem(item, index, filteredItems);
        }).toList(),

        // Bottom spacing
        SizedBox(height: 30),
      ]),
    );
  }

  SliverList _buildEmptyWishlistContent() {
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(height: 100),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.heart,
                size: 50,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Your wishlist is empty',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Start adding items you love to your wishlist',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Start Shopping',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildWishlistItem(WishlistItemEntity item, int index, List<WishlistItemEntity> filteredItems) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        children: [
          // Product Image and Info
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),

                      // Price
                      Text(
                        'P${item.price}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Pallete.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),

                // Remove Button
                IconButton(
                  onPressed: () => _removeFromWishlist(index, filteredItems),
                  icon: Icon(
                    Iconsax.heart_remove,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Share functionality
                    },
                    icon: Icon(Iconsax.share, size: 14),
                    label: Text(
                      'Share',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _addToCart(item),
                    icon: Icon(Iconsax.shopping_cart, size: 14, color: Colors.white),
                    label: Text(
                      'Add to Cart',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}