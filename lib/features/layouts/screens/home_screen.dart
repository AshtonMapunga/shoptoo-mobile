import 'package:flutter/material.dart';
import 'package:shoptoo/features/layouts/screens/main_layout.dart';
import 'package:shoptoo/features/layouts/widgets/advertising.dart';
import 'package:shoptoo/features/layouts/widgets/app_header.dart';
import 'package:shoptoo/features/layouts/widgets/categories.dart';
import 'package:shoptoo/features/layouts/widgets/products.dart';
import 'package:shoptoo/features/layouts/widgets/slider.dart';
import 'package:shoptoo/features/layouts/widgets/special_offer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showSearchOnly = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 100 && !_showSearchOnly) {
      setState(() {
        _showSearchOnly = true;
      });
    } else if (_scrollController.offset <= 100 && _showSearchOnly) {
      setState(() {
        _showSearchOnly = false;
      });
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    print('Selected category index: $index');
  }

  void _onSpecialOfferPressed() {
    print('Special offer button pressed!');
  }

  final List<Product> _featuredProducts = sampleProducts;
  final List<AdvertiseProduct> _advertisingProducts = sampleAdProducts;

  void _onSeeAllPressed() {
    print('See all products pressed');
  }

  void _onProductPressed(Product product) {
    print('Product pressed: ${product.name}');
  }

  void _onAdvertsingProductPressed(AdvertiseProduct product) {
    print('Product pressed: ${product.name}');
  }

  final List<String> _sliderImages = [
    'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&h=400&fit=crop',
    'https://images.unsplash.com/photo-1556760544-74068565f05c?w=800&h=400&fit=crop',
    'https://images.unsplash.com/photo-1556742044-5f1d0c6f5b0c?w=800&h=400&fit=crop',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&h=400&fit=crop',
  ];

  void _onAddToCart(Product product) {
    print('Add to cart: ${product.name}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      floating: false,
      snap: false,
      automaticallyImplyLeading: false,
      expandedHeight: 160.0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final safeAreaTop = MediaQuery.of(context).padding.top;
          final appBarHeight = constraints.biggest.height;
          final visibleMainHeight = appBarHeight - safeAreaTop;

          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            titlePadding: const EdgeInsets.all(0),
            expandedTitleScale: 1.0,
            title: _showSearchOnly
                ? Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: AppHeader(
                      showSearchBar: true,
                      searchHint: 'Search Shoptoo!',
                    ),
                  )
                : null,
            background: _buildExpandedHeader(),
          );
        },
      ),
    );
  }

  Widget _buildExpandedHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // Buttons Row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Truly Africa button
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    backgroundColor: Colors.yellow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/logo.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_bag,
                            size: 20,
                            color: Colors.black,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Truly Africa',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Buy Online button
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/onlinebuy.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_cart,
                            size: 20,
                            color: Colors.black,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Buy Online',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Deliver button
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/deliver.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.local_shipping,
                            size: 20,
                            color: Colors.black,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Deliver',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Search bar
          AppHeader(
            showSearchBar: true,
            searchHint: 'Search Shoptoo!',
            buttons: const ['Truly Africa', 'Buy Online', 'Deliver'],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      initialTabIndex: 0,
      customHeader: _buildCustomHeader(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories section
                    CategoryComponent(
                      onCategorySelected: _onCategorySelected,
                      initialSelectedIndex: _selectedCategoryIndex,
                    ),
                    const SizedBox(height: 2),

                    CreativeSlider(
                      imageUrls: _sliderImages,
                      height: 200,
                      borderRadius: 20,
                      autoPlayInterval: const Duration(seconds: 4),
                      onTap: () {
                        print('Slider tapped at page');
                      },
                    ),
                    const SizedBox(height: 20),

                    ProductsComponent(
                      products: _featuredProducts,
                      onSeeAllPressed: _onSeeAllPressed,
                      onProductPressed: _onProductPressed,
                      onAddToCart: _onAddToCart,
                    ),
                    const SizedBox(height: 20),

                    AdvertisingComponent(
                      height: 300,
                      title: "Premium Products",
                      products: _advertisingProducts,
                      onProductPressed: _onAdvertsingProductPressed,
                      backgroundImageUrl:
                          "https://images.unsplash.com/photo-1556760544-74068565f05c?w=800&h=400&fit=crop",
                      showProductName: true,
                      productImageHeight: 150,
                      borderRadius: 24.0,
                    ),
                    const SizedBox(height: 20),

                    SpecialOfferComponent(
                      title: 'Summer Sale!',
                      description:
                          'Up to 50% off on summer collection. Don\'t miss out!',
                      buttonText: 'Explore',
                      imagePath: 'assets/images/summer_sale.png',
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        print('Summer sale button pressed!');
                      },
                    ),
                    const SizedBox(height: 30),

                    ProductsComponent(
                      title: 'New Arrivals',
                      products: sampleProducts.sublist(0, 3),
                      onSeeAllPressed: _onSeeAllPressed,
                      onAddToCart: _onAddToCart,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}



final List<AdvertiseProduct> sampleAdProducts = [
  AdvertiseProduct(
    name: 'Premium Product 1',
    imageUrl: 'https://example.com/premium1.jpg',
    price: 99.99,
  ),
  AdvertiseProduct(
    name: 'Premium Product 2',
    imageUrl: 'https://example.com/premium2.jpg',
    price: 129.99,
  ),
];