// features/categories/screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/app/providers/categories_provider.dart';
import 'package:shoptoo/features/categories/domain/entities/category_entity.dart';
import 'package:shoptoo/features/categories/screens/category_product_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CategoryEntity> _filteredCategories = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final categoriesState = ref.read(categoriesControllerProvider);

    categoriesState.whenData((categories) {
      setState(() {
        if (_searchController.text.isEmpty) {
          _filteredCategories = categories;
          _isSearching = false;
        } else {
          _isSearching = true;
          final query = _searchController.text.toLowerCase();
          _filteredCategories = categories.where((category) {
            return category.name.toLowerCase().contains(query) ||
                (category.description?.toLowerCase().contains(query) ?? false);
          }).toList();
        }
      });
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      final categoriesState = ref.read(categoriesControllerProvider);
      categoriesState.whenData((categories) {
        _filteredCategories = categories;
      });
      _isSearching = false;
    });
  }

  void _onCategoryTap(CategoryEntity category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsByCategoryScreen(category: category),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'electronics':
        return Iconsax.mobile;
      case 'fashion':
        return Iconsax.bag_2;
      case 'home & garden':
      case 'home':
        return Iconsax.house_2;
      case 'beauty':
      case 'health':
        return Iconsax.heart;
      case 'sports':
        return Iconsax.activity;
      case 'books':
        return Iconsax.book_1;
      case 'toys':
        return Iconsax.gameboy;
      case 'automotive':
        return Iconsax.car;
      case 'groceries':
        return Iconsax.shopping_cart;
      case 'furniture':
        return Iconsax.element_4;
      case 'computers':
        return Iconsax.monitor_mobbile;
      case 'jewelry':
        return Iconsax.gemini;
 
      case 'bags':
        return Iconsax.bag;
      case 'watches':
        return Iconsax.watch;
      case 'music':
        return Iconsax.music;
      case 'kitchen':
        return Iconsax.cup;
      
      case 'pet':
        return Iconsax.pet;
      default:
        return Iconsax.category;
    }
  }

  Color _getCategoryColor(int index) {
    final colors = [
      Pallete.primaryColor,
      Color(0xFF6366F1), // Indigo
      Color(0xFF10B981), // Emerald
      Color(0xFFF59E0B), // Amber
      Color(0xFFEF4444), // Red
      Color(0xFF8B5CF6), // Violet
      Color(0xFF06B6D4), // Cyan
      Color(0xFFEC4899), // Pink
      Color(0xFF14B8A6), // Teal
      Color(0xFFF97316), // Orange
      Color(0xFF8B4513), // Brown
      Color(0xFF64748B), // Slate
      Color(0xFFDC2626), // Rose
      Color(0xFF7C3AED), // Purple
      Color(0xFF059669), // Green
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesControllerProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: true,
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 132, 245, 98).withOpacity(0.1),
                        Color.fromARGB(255, 148, 247, 161).withOpacity(0.05),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 70,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Categories',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                       
                        const SizedBox(height: 10),

                        // Search Bar
                        _buildSearchBar(),
                      ],
                    ),
                  ),
                ),
              ),
              title: _isSearching || _searchController.text.isNotEmpty
                  ? Text(
                      'Search Results (${_filteredCategories.length})',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    )
                  : null,
              centerTitle: true,
            ),
          ];
        },
        body: categoriesState.when(
          loading: () => _buildLoadingState(),
          error: (error, stackTrace) => _buildErrorState(error.toString()),
          data: (categories) {
            if (_filteredCategories.isEmpty && !_isSearching) {
              _filteredCategories = categories;
            }

            return _filteredCategories.isEmpty
                ? _buildEmptyState()
                : _buildCategoriesList(categories: _filteredCategories);
          },
        ),
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
            color: Color(0xFF1E293B).withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Iconsax.search_normal_1,
                    color: Color(0xFF94A3B8),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search categories...',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w500,
                      ),
                      cursorColor: Pallete.primaryColor,
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: _clearSearch,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF1F5F9),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
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

  Widget _categoryImageOrIcon(CategoryEntity category, IconData icon, Color color, int index) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: category.image?.src != null && category.image!.src!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  category.image!.src!,
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withOpacity(0.1),
                      ),
                      child: Icon(
                        icon,
                        size: 24,
                        color: color,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: color,
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
              ),
      ),
    );
  }

  Widget _buildCategoriesList({required List<CategoryEntity> categories}) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(categoriesControllerProvider.notifier).refresh();
      },
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final icon = _getCategoryIcon(category.name);
          final color = _getCategoryColor(index);

          return _buildCategoryListItem(
            category: category,
            icon: icon,
            color: color,
            index: index,
          );
        },
      ),
    );
  }

  Widget _buildCategoryListItem({
    required CategoryEntity category,
    required IconData icon,
    required Color color,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onCategoryTap(category),
          borderRadius: BorderRadius.circular(5),
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFFF1F5F9),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A1E293B),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Category Image/Icon
                _categoryImageOrIcon(category, icon, color, index),
                
                const SizedBox(width: 16),
                
                // Category Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Name
                      Text(
                        category.name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // Description (if available)
                      if (category.description != null && category.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            category.description!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      
                     
                    ],
                  ),
                ),
                
                // Chevron Icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.1),
                  ),
                  child: Icon(
                    Iconsax.arrow_right_3,
                    size: 16,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 24),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFFF1F5F9),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Skeleton for icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF1F5F9),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Skeleton for text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xFFF1F5F9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xFFF1F5F9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 80,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xFFF1F5F9),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Skeleton for chevron
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF1F5F9),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
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
              child: Icon(Iconsax.warning_2, size: 50, color: Colors.red),
            ),
            const SizedBox(height: 24),
            Text(
              'Unable to Load Categories',
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
                error,
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
                ref.refresh(categoriesControllerProvider);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
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
    );
  }

  Widget _buildEmptyState() {
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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6366F1).withOpacity(0.1),
                    Color(0xFF8B5CF6).withOpacity(0.05),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Iconsax.category,
                  size: 64,
                  color: Pallete.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              _isSearching ? 'No Results Found' : 'No Categories Available',
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
                _isSearching
                    ? 'We couldn\'t find any categories matching "${_searchController.text}". Try searching with different keywords.'
                    : 'Categories will appear here once they\'re available. Check back soon!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_isSearching)
              ElevatedButton(
                onPressed: _clearSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.primaryColor,
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
                  'Clear Search',
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
}