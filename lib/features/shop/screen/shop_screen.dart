import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/auth/data/productssample.dart';
import 'package:shoptoo/features/cart/screens/cart_screen.dart';
import 'package:shoptoo/features/layouts/screens/main_layout.dart';
import 'package:shoptoo/features/products/screens/product_details_screen.dart';
import 'package:shoptoo/features/search/screens/search_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:shoptoo/shared/widgets/cards/product_card.dart';

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
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      id: '3',
      name: 'Electronics',
      icon: Iconsax.monitor,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      id: '4',
      name: 'Home & Garden',
      icon: Iconsax.home,
      color: Pallete.primaryColor,
    ),
    ShopCategory(
      id: '5',
      name: 'Furniture',
      icon: Iconsax.element_3,
      color: Pallete.primaryColor,
    ),
  
  ];

    final List<Product> _products = sampleProducts;

  List<Product> get _filteredProducts {
    var products = _products;

    // Note: Since Product class doesn't have category, we can't filter by category
    // If you need category filtering, you'll need to add category field to Product class
    
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
        // Sort by isNew first, then by name as fallback
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

    // Filter by category if selected and Product has category field
    // Note: You'll need to add category to Product class first
    if (_selectedCategory > 0 && _categories[_selectedCategory].name != 'All') {
      // Uncomment when you add category to Product class
      // products = products.where((product) => product.category == _categories[_selectedCategory].name).toList();
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

  void _addToCart(Product product) {
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

  void _addToWishlist(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to wishlist'),
        backgroundColor: Colors.pink,
      ),
    );
  }

  void _onProductPressed(Product product) {
    // Navigate to product details screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          product: product,
        ),
      ),
    );
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
      ), appBar: null,
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
          final product = _filteredProducts[index];
          return ProductCardComponent(
            product: product,
            onTap: () => _onProductPressed(product),
            onAddToCart: () => _addToCart(product),
            onAddToWishlist: () => _addToWishlist(product),
            width: MediaQuery.of(context).size.width / 2 - 24, // Adjust for grid spacing
            imageHeight: 110, // Matches the height in original design
          );
        },
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

// Remove the old Productt class and keep only the Product class from product_card_component.dart