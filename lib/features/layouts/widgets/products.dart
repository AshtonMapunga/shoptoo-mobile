import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/core/utils/assets_utils.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class ProductsComponent extends StatelessWidget {
  final String title;
  final String seeAllText;
  final VoidCallback? onSeeAllPressed;
  final List<Product> products;
  final ValueChanged<Product>? onProductPressed;
  final ValueChanged<Product>? onAddToCart;
  final ValueChanged<Product>? onAddToWishlist;

  const ProductsComponent({
    Key? key,
    this.title = 'Featured Products',
    this.seeAllText = 'See all',
    this.onSeeAllPressed,
    required this.products,
    this.onProductPressed,
    this.onAddToCart,
    this.onAddToWishlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: onSeeAllPressed,
              child: Image.asset(
                Assets.forwardArrow,
                fit: BoxFit.contain,
                height: 25,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () => onProductPressed?.call(product),
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image with badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: SizedBox(
                              height: 140,
                              width: double.infinity,
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Pallete.primaryColor.withOpacity(0.1),
                                    child: Icon(
                                      Icons.shopping_bag,
                                      color: Pallete.primaryColor,
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          
                          // Discount Badge
                          if (product.discount > 0)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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

                          // New Badge - Positioned to avoid overlap
                          if (product.isNew)
                            Positioned(
                              top: product.isFeatured ? 35 : 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => onAddToWishlist?.call(product),
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
                      
                      const SizedBox(height: 8),
                      
                      // Product details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Product Name
                              Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              // Rating
                              Row(
                                children: [
                                  Icon(Iconsax.star1, color: Colors.amber, size: 12),
                                  const SizedBox(width: 4),
                                  Text(
                                    product.rating.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '(${product.reviewCount})',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
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
                                    'P${product.price}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Pallete.primaryColor,
                                    ),
                                  ),
                                  if (product.originalPrice.isNotEmpty && double.parse(product.originalPrice) > double.parse(product.price))
                                    Text(
                                      'P${product.originalPrice}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
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
                                  onPressed: () => onAddToCart?.call(product),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Pallete.primaryColor,
                                    side: BorderSide(
                                      color: Pallete.primaryColor,
                                      width: 1,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Add to Cart',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
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
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Product {
  final String name;
  final String price;
  final String originalPrice;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int discount;
  final bool isFeatured;
  final bool isNew;

  Product({
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    this.discount = 0,
    this.isFeatured = false,
    this.isNew = false,
  });
}

// Updated sample product data to match ShopScreen structure
final List<Product> sampleProducts = [
  Product(
    name: 'Wireless Bluetooth ',
    price: '199.99',
    originalPrice: '249.99',
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop',
    rating: 4.5,
    reviewCount: 128,
    discount: 20,
    isFeatured: true,
    isNew: true,
  ),
  Product(
    name: 'Modern Office Chair',
    price: '299.99',
    originalPrice: '399.99',
    imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
    rating: 4.8,
    reviewCount: 89,
    discount: 25,
    isFeatured: true,
    isNew: false,
  ),
  Product(
    name: 'Running Shoes',
    price: '129.99',
    originalPrice: '159.99',
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=300&fit=crop',
    rating: 4.3,
    reviewCount: 256,
    discount: 18,
    isFeatured: false,
    isNew: true,
  ),
  Product(
    name: 'Smart Watch Series 5',
    price: '399.99',
    originalPrice: '499.99',
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=300&fit=crop',
    rating: 4.7,
    reviewCount: 312,
    discount: 20,
    isFeatured: true,
    isNew: false,
  ),
  Product(
    name: 'Designer Backpack',
    price: '89.99',
    originalPrice: '119.99',
    imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
    rating: 4.4,
    reviewCount: 167,
    discount: 25,
    isFeatured: false,
    isNew: true,
  ),
];