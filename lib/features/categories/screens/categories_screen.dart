import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/categories/screens/category_product_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Electronics',
      imageUrl: 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=800&auto=format&fit=crop',
      icon: Iconsax.mobile,
      color: Pallete.primaryColor,
      productCount: 125,
    ),
    Category(
      id: '2',
      name: 'Fashion',
      imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w-800&auto=format&fit=crop',
      icon: Iconsax.bag,
      color: Colors.pink,
      productCount: 89,
    ),
    Category(
      id: '3',
      name: 'Home & Garden',
      imageUrl: 'https://images.unsplash.com/photo-1615529328331-f8917597711f?w=800&auto=format&fit=crop',
      icon: Iconsax.home,
      color: Colors.green,
      productCount: 76,
    ),
    Category(
      id: '4',
      name: 'Beauty & Health',
      imageUrl: 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=800&auto=format&fit=crop',
      icon: Iconsax.heart,
      color: Colors.purple,
      productCount: 64,
    ),
    Category(
      id: '5',
      name: 'Sports & Outdoors',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=800&auto=format&fit=crop',
      icon: Iconsax.activity,
      color: Colors.orange,
      productCount: 98,
    ),
    Category(
      id: '6',
      name: 'Books & Stationery',
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&auto=format&fit=crop',
      icon: Iconsax.book,
      color: Colors.brown,
      productCount: 45,
    ),
    Category(
      id: '7',
      name: 'Toys & Games',
      imageUrl: 'https://images.unsplash.com/photo-1531259683007-016a7b628fc3?w=800&auto=format&fit=crop',
      icon: Iconsax.game,
      color: Colors.blue,
      productCount: 32,
    ),
    Category(
      id: '8',
      name: 'Automotive',
      imageUrl: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=800&auto=format&fit=crop',
      icon: Iconsax.car,
      color: Colors.red,
      productCount: 57,
    ),
    Category(
      id: '9',
      name: 'Groceries',
      imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800&auto=format&fit=crop',
      icon: Iconsax.shopping_cart,
      color: Colors.teal,
      productCount: 210,
    ),
    Category(
      id: '10',
      name: 'Jewelry',
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=800&auto=format&fit=crop',
      icon: Icons.diamond,
      color: Colors.amber,
      productCount: 42,
    ),
  ];

  // Search functionality
  List<Category> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredCategories = _categories;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredCategories = _categories;
        _isSearching = false;
      } else {
        _isSearching = true;
        final query = _searchController.text.toLowerCase();
        _filteredCategories = _categories.where((category) {
          return category.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredCategories = _categories;
      _isSearching = false;
    });
  }

  void _onCategoryTap(Category category) {
    // Navigate to products by category screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsByCategoryScreen(
          category: category,
        ),
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
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Background decoration
                    Positioned(
                      top: -60,
                      right: -60,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.primaryColor.withOpacity(0.1),
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
                            'Categories',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                        
                          const SizedBox(height: 16),
                          
                          // Search Bar
                          _buildSearchBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              title: _isSearching || _searchController.text.isNotEmpty
                  ? Text(
                      '${_filteredCategories.length} categories',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )
                  : null,
              centerTitle: true,
            ),
          ];
        },
        body: _filteredCategories.isEmpty
            ? _buildEmptyState()
            : _buildCategoriesGrid(),
      ),
    );
  }

  Widget _buildSearchBar() {
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search categories...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: _clearSearch,
                      child: Icon(
                        Iconsax.close_circle,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _filteredCategories.length,
        itemBuilder: (context, index) {
          final category = _filteredCategories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    return GestureDetector(
      onTap: () => _onCategoryTap(category),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Category Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                child: Stack(
                  children: [
                    // Network image with loading and error states
                    Image.network(
                      category.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[100],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              color: category.color,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: category.color.withOpacity(0.1),
                          child: Center(
                            child: Icon(
                              category.icon,
                              size: 40,
                              color: category.color,
                            ),
                          ),
                        );
                      },
                    ),
                    
                    // Gradient overlay for better text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Category Info
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Name
                  Text(
                    category.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Pallete.primaryColor.withOpacity(0.1),
            ),
            child: Icon(
              Iconsax.category,
              size: 50,
              color: Pallete.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No categories found',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'No categories match your search. Try a different keyword.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _clearSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: Pallete.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Clear Search',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final IconData icon;
  final Color color;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.icon,
    required this.color,
    required this.productCount,
  });
}