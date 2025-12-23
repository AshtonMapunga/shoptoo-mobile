import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<WishlistItem> _wishlistItems = [
    WishlistItem(
      id: '1',
      name: 'Wireless Bluetooth Headphones',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop',
      price: 199.99,
      originalPrice: 249.99,
      isInStock: true,
      rating: 4.5,
      reviewCount: 128,
      size: 'M',
      color: 'Black',
    ),
    WishlistItem(
      id: '2',
      name: 'Modern Ergonomic Office Chair',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
      price: 299.99,
      originalPrice: 399.99,
      isInStock: true,
      rating: 4.8,
      reviewCount: 89,
      size: 'One ',
      color: 'Brown',
    ),
    WishlistItem(
      id: '3',
      name: 'Premium Running Shoes',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=300&fit=crop',
      price: 129.99,
      originalPrice: 159.99,
      isInStock: false,
      rating: 4.3,
      reviewCount: 256,
      size: '42',
      color: 'Blue',
    ),
    WishlistItem(
      id: '4',
      name: 'Smart Watch Series 5',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=300&fit=crop',
      price: 399.99,
      originalPrice: 499.99,
      isInStock: true,
      rating: 4.7,
      reviewCount: 312,
      size: 'M',
      color: 'Black',
    ),
    WishlistItem(
      id: '5',
      name: 'Designer Backpack',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
      price: 89.99,
      originalPrice: 119.99,
      isInStock: true,
      rating: 4.4,
      reviewCount: 167,
      size: 'L',
      color: 'Gray',
    ),
    WishlistItem(
      id: '6',
      name: 'Wireless Gaming Mouse',
      imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400&h=300&fit=crop',
      price: 79.99,
      originalPrice: 99.99,
      isInStock: false,
      rating: 4.6,
      reviewCount: 203,
      size: 'Standard',
      color: 'RGB',
    ),
  ];

  bool _showOnlyInStock = false;
  String _selectedSort = 'Recently Added';

  List<WishlistItem> get _filteredItems {
    var items = _wishlistItems;
    
    // Filter by stock status
    if (_showOnlyInStock) {
      items = items.where((item) => item.isInStock).toList();
    }
    
    // Sort items
    switch (_selectedSort) {
      case 'Price: Low to High':
        items.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        items.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Highest Rated':
        items.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Recently Added':
      default:
        // Keep original order (most recent first)
        break;
    }
    
    return items;
  }

  void _removeFromWishlist(int index) {
    final item = _filteredItems[index];
    setState(() {
      _wishlistItems.removeWhere((element) => element.id == item.id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed from wishlist'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _wishlistItems.add(item);
            });
          },
        ),
      ),
    );
  }

  void _moveToCart(int index) {
    final item = _filteredItems[index];
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
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
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
                    'Filter & Sort',
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
              
              // Stock Filter
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.box_tick, color: Pallete.primaryColor),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Show only in stock',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Switch(
                      value: _showOnlyInStock,
                      onChanged: (value) {
                        setState(() {
                          _showOnlyInStock = value;
                        });
                        Navigator.pop(context);
                      },
                      activeColor: Pallete.primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              
              // Sort Options
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
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
            ],
          ),
        ),
      ),
    );
  }

  void _showEmptyWishlist() {
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
              setState(() {
                _wishlistItems.clear();
              });
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                expandedHeight: 120,
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
                  if (_wishlistItems.isNotEmpty)
                    IconButton(
                      icon: Icon(Iconsax.filter, color: Colors.black),
                      onPressed: _showFilters,
                    ),
                  if (_wishlistItems.isNotEmpty)
                    IconButton(
                      icon: Icon(Iconsax.trash, color: Colors.red),
                      onPressed: _showEmptyWishlist,
                    ),
                ],
              ),

              // Content based on wishlist state
              if (_wishlistItems.isEmpty)
                _buildEmptyWishlistContent()
              else
                _buildWishlistContent(),
            ],
          ),
        ],
      ),
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

  SliverList _buildWishlistContent() {
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
                '${_filteredItems.length} ${_filteredItems.length == 1 ? 'item' : 'items'}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              if (_showOnlyInStock)
                Text(
                  'In stock only',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Pallete.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),

        // Wishlist Items
        ..._filteredItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _buildWishlistItem(item, index);
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
                  borderRadius: BorderRadius.circular(12),
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

  Widget _buildWishlistItem(WishlistItem item, int index) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (!item.isInStock)
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            'OUT OF STOCK',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
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

                      // Rating
                      Row(
                        children: [
                          Icon(Iconsax.star1, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            item.rating.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '(${item.reviewCount})',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Size and Color
                      Row(
                        children: [
                          if (item.size.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Size: ${item.size}',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          if (item.size.isNotEmpty && item.color.isNotEmpty)
                            SizedBox(width: 6),
                          if (item.color.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Color: ${item.color}',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Price
                      Row(
                        children: [
                          Text(
                            'P${item.price.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Pallete.primaryColor,
                            ),
                          ),
                          if (item.originalPrice > item.price) ...[
                            SizedBox(width: 8),
                            Text(
                              'P${item.originalPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Remove Button
                IconButton(
                  onPressed: () => _removeFromWishlist(index),
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
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: item.isInStock ? () => _moveToCart(index) : null,
                    icon: Icon(Iconsax.shopping_cart, size: 14, color: Colors.white,),
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
                        borderRadius: BorderRadius.circular(8),
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

class WishlistItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final bool isInStock;
  final double rating;
  final int reviewCount;
  final String size;
  final String color;

  WishlistItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.isInStock,
    required this.rating,
    required this.reviewCount,
    required this.size,
    required this.color,
  });
}