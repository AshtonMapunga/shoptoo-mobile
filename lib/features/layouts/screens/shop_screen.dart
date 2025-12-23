import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/cart/screens/cart_screen.dart';
import 'package:shoptoo/features/products/screens/product_details_screen.dart';
import 'package:shoptoo/features/search/screens/search_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';


class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedCategory = 0;
  String _selectedSort = 'Popular';
  int _selectedFilter = 0;
  int _cartItemCount = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<ShopCategory> _categories = [
    ShopCategory(
      id: '1',
      name: 'All',
      icon: Iconsax.category,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      id: '2',
      name: 'Electronics',
      icon: Iconsax.mobile,
      color: Colors.blue,
    ),
    ShopCategory(
      id: '3',
      name: 'Fashion',
      icon: Iconsax.shopping_bag,
      color: Colors.pink,
    ),
    ShopCategory(
      id: '4',
      name: 'Home & Garden',
      icon: Iconsax.home,
      color: Colors.green,
    ),
    ShopCategory(
      id: '5',
      name: 'Beauty',
      icon: Iconsax.heart,
      color: Colors.purple,
    ),
    ShopCategory(
      id: '6',
      name: 'Sports',
      icon: Iconsax.health,
      color: Colors.orange,
    ),
  ];

  final List<Productt> _products = [
    Productt(
      id: '1',
      name: 'Wireless Bluetooth Headphones',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop',
      price: 199.99,
      originalPrice: 249.99,
      rating: 4.5,
      reviewCount: 128,
      category: 'Electronics',
      isFeatured: true,
      isNew: true,
      discount: 20,
    ),
    Productt(
      id: '2',
      name: 'Modern Office Chair',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
      price: 299.99,
      originalPrice: 399.99,
      rating: 4.8,
      reviewCount: 89,
      category: 'Home & Garden',
      isFeatured: true,
      isNew: false,
      discount: 25,
    ),
    Productt(
      id: '3',
      name: 'Running Shoes',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=300&fit=crop',
      price: 129.99,
      originalPrice: 159.99,
      rating: 4.3,
      reviewCount: 256,
      category: 'Sports',
      isFeatured: false,
      isNew: true,
      discount: 18,
    ),
    Productt(
      id: '4',
      name: 'Smart Watch Series 5',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=300&fit=crop',
      price: 399.99,
      originalPrice: 499.99,
      rating: 4.7,
      reviewCount: 312,
      category: 'Electronics',
      isFeatured: true,
      isNew: false,
      discount: 20,
    ),
    Productt(
      id: '5',
      name: 'Designer Backpack',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
      price: 89.99,
      originalPrice: 119.99,
      rating: 4.4,
      reviewCount: 167,
      category: 'Fashion',
      isFeatured: false,
      isNew: true,
      discount: 25,
    ),
    Productt(
      id: '6',
      name: 'Wireless Gaming Mouse',
      imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=400&h=300&fit=crop',
      price: 79.99,
      originalPrice: 99.99,
      rating: 4.6,
      reviewCount: 203,
      category: 'Electronics',
      isFeatured: false,
      isNew: false,
      discount: 20,
    ),
    Productt(
      id: '7',
      name: 'Skincare Set',
      imageUrl: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400&h=300&fit=crop',
      price: 149.99,
      originalPrice: 199.99,
      rating: 4.5,
      reviewCount: 98,
      category: 'Beauty',
      isFeatured: true,
      isNew: false,
      discount: 25,
    ),
    Productt(
      id: '8',
      name: 'Yoga Mat Premium',
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=300&fit=crop',
      price: 49.99,
      originalPrice: 69.99,
      rating: 4.2,
      reviewCount: 145,
      category: 'Sports',
      isFeatured: false,
      isNew: true,
      discount: 28,
    ),
  ];

  List<Productt> get _filteredProducts {
    var products = _products;

    if (_selectedCategory > 0) {
      final category = _categories[_selectedCategory];
      products = products.where((product) => product.category == category.name).toList();
    }

    switch (_selectedSort) {
      case 'Price: Low to High':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Highest Rated':
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        products.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 'Popular':
      default:
        products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }

    return products;
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

              // Sort Options
              Container(
                padding: EdgeInsets.all(16),
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
                    SizedBox(height: 12),
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
              SizedBox(height: 20),

              // Price Range
              Container(
                padding: EdgeInsets.all(16),
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
                    SizedBox(height: 12),
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
                        SizedBox(width: 12),
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
              SizedBox(height: 20),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSort = 'Popular';
                          _selectedCategory = 0;
                        });
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
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
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16),
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
      pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(
        allProducts: _products,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 500),
    ),
  );
}

  void _addToCart(Productt product) {
    setState(() {
      _cartItemCount++;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        backgroundColor: Pallete.primaryColor,
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {

                Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(),
        ),
      );
         
          },
        ),
      ),
    );
  }

  void _addToWishlist(Productt product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to wishlist'),
        backgroundColor: Colors.pink,
      ),
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
              floating: true,
              expandedHeight: 140, // Increased height for search bar
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Animated half circles like login page
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
                    
                    // Search Bar and Cart
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
                // Removed search icon from here since it's now in the search bar
                IconButton(
                  icon: Icon(Iconsax.filter, color: Colors.black),
                  onPressed: _showFilters,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: _buildCategories(),
            ),
          ];
        },
        body: _buildProducts(),
      ),
    );
  }
Widget _buildSearchBarWithCart() {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: Offset(0, 4),
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Iconsax.search_normal,
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
        
        // Cart Icon with Counter
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Pallete.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Iconsax.shopping_bag,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            
            // Cart Counter Badge
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
                    transitionBuilder: (Widget child, Animation<double> animation) {
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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
      onTap: () {
        setState(() {
          _selectedCategory = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? category.color : Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
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
            SizedBox(width: 6),
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

  Widget _buildProducts() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, index) {
          return _buildProductCard(_filteredProducts[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Productt product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Discount Badge
                if (product.discount > 0)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${product.discount}% OFF',
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // Featured Badge
                if (product.isFeatured)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Pallete.primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Featured',
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // New Badge - Positioned properly to avoid overlap
                if (product.isNew)
                  Positioned(
                    top: product.isFeatured ? 30 : 6,
                    right: 6,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'New',
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // Wishlist Button
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => _addToWishlist(product),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: Icon(
                        Iconsax.heart,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Name
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Rating
                    Row(
                      children: [
                        Icon(Iconsax.star1, color: Colors.amber, size: 10),
                        SizedBox(width: 2),
                        Text(
                          product.rating.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '(${product.reviewCount})',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'P${product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Pallete.primaryColor,
                          ),
                        ),
                        if (product.originalPrice > product.price)
                          Text(
                            'P${product.originalPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _addToCart(product),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Pallete.primaryColor,
                          side: BorderSide(
                            color: Pallete.primaryColor,
                            width: 1,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Pallete.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  ShopCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class Productt {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isFeatured;
  final bool isNew;
  final int discount;

  Productt({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.category,
    required this.isFeatured,
    required this.isNew,
    required this.discount,
  });
}