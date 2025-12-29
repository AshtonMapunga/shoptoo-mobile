import 'package:flutter/material.dart';
import 'package:shoptoo/features/auth/data/productssample.dart';
import 'package:shoptoo/features/layouts/screens/main_layout.dart';
import 'package:shoptoo/features/layouts/widgets/advertising.dart';
import 'package:shoptoo/features/layouts/widgets/app_header.dart';
import 'package:shoptoo/features/layouts/widgets/brands.dart';
import 'package:shoptoo/features/layouts/widgets/categories.dart';
import 'package:shoptoo/features/layouts/widgets/products.dart';
import 'package:shoptoo/features/layouts/widgets/slider.dart';
import 'package:shoptoo/features/layouts/widgets/special_offer.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/features/shop/screen/shop_screen.dart';

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

  final List<ProductEntity> _featuredProducts = sampleProducts;
  final List<AdvertiseProduct> _advertisingProducts = sampleAdProducts;

  void _onSeeAllPressed() {
    print('See all products pressed');
  }

  void _onProductPressed(ProductEntity product) {
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


  final List<Brand> brands = [
    Brand(id: '1', name: 'KDV', imageUrl: 'assets/icons/kdv.png'),
    Brand(id: '2', name: 'P and D', imageUrl: 'assets/icons/pd.png'),
    Brand(id: '3', name: 'Samsung', imageUrl: 'assets/icons/samsung.png'),
    Brand(id: '4', name: 'SPJ', imageUrl: 'assets/icons/spj.png'),
    Brand(id: '5', name: 'Defy', imageUrl: 'assets/icons/defy.png'),
        Brand(id: '6', name: 'Hisense', imageUrl: 'assets/icons/hisense.png'),
  ];


  void _onAddToCart(ProductEntity product) {
    print('Add to cart: ${product.name}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }



  

  Widget _buildBodyContent() {
    return Column(
      children: [
       
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
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
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
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
                      borderRadius: 5,
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
                      productImageHeight: 180,
                      borderRadius: 5.0,
                    ),
                    const SizedBox(height: 20),


 BrandComponent(
            brands: brands,
            height: 120,
            itemWidth: 100,
            itemSpacing: 20,
            animationSpeed: 40, 
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
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      initialTabIndex: 0,
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: AppHeader(showSearchBar: true, searchHint: 'Search Shoptoo!'),
      ),
      
      body: SafeArea(
        child: _buildBodyContent(),
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