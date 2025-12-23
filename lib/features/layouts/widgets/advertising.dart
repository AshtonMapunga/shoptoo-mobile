import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class AdvertisingComponent extends StatelessWidget {
  final String title;
  final double height;
  final String? backgroundImageUrl;
  final List<AdvertiseProduct> products;
  final ValueChanged<AdvertiseProduct>? onProductPressed;
  final ValueChanged<AdvertiseProduct>? onAddToCart;
  final bool showProductName;
  final double productImageHeight;
  final double borderRadius;

  const AdvertisingComponent({
    Key? key,
    this.title = 'Featured Products',
    this.backgroundImageUrl,
    required this.products,
    this.onProductPressed,
    this.onAddToCart,
    this.height = 200,
    this.showProductName = true,
    this.productImageHeight = 140,
    this.borderRadius = 16.0,
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
          ],
        ),
        const SizedBox(height: 5),

        // Main container with optional background image
        Container(
          width: double.infinity, // Full screen width
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: backgroundImageUrl != null
                ? DecorationImage(
                    image: NetworkImage(backgroundImageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              children: [
                // Background image layer (if provided)
                if (backgroundImageUrl != null)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(backgroundImageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                // Centered scrollable products layer on top of background
                Center(
                  child: SizedBox(
                    height: productImageHeight + (showProductName ? 60 : 0), // Adjust height based on content
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
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image with customizable height
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: SizedBox(
                                    height: productImageHeight,
                                    width: double.infinity,
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
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
                                            size: 40,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                
                                // Optional product name
                                if (showProductName) ...[
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Pallete.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AdvertiseProduct {
  final String name;
  final String imageUrl;
  final double? price;

  AdvertiseProduct({
    required this.name,
    required this.imageUrl,
    this.price,
  });
}

// Sample product data with Unsplash images
final List<AdvertiseProduct> sampleAdProducts = [
  AdvertiseProduct(
    name: 'Modern Chair',
    imageUrl:
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
    price: 299.99,
  ),
  AdvertiseProduct(
    name: 'Wireless Headphones',
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop',
    price: 199.99,
  ),
  AdvertiseProduct(
    name: 'Smart Watch',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=300&fit=crop',
    price: 399.99,
  ),
  AdvertiseProduct(
    name: 'Camera Lens',
    imageUrl:
        'https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?w=400&h=300&fit=crop',
    price: 599.99,
  ),
  AdvertiseProduct(
    name: 'Running Shoes',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=300&fit=crop',
    price: 129.99,
  ),
  AdvertiseProduct(
    name: 'Backpack',
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop',
    price: 89.99,
  ),
];