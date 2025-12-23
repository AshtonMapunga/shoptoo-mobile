import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class ProductCardComponent extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onAddToWishlist;
  final double width;
  final double imageHeight;

  const ProductCardComponent({
    Key? key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onAddToWishlist,
    this.width = 160,
    this.imageHeight = 140,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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
            _buildProductImage(),
            
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
                    _buildRating(),
                    
                    // Price
                    _buildPrice(),
                    
                    // Add to Cart Button
                    _buildAddToCartButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: SizedBox(
            height: imageHeight,
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
            onTap: onAddToWishlist,
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
    );
  }

  Widget _buildRating() {
    return Row(
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
    );
  }

  Widget _buildPrice() {
    return Column(
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
        if (product.originalPrice.isNotEmpty && 
            double.tryParse(product.originalPrice) != null &&
            double.tryParse(product.price) != null &&
            double.parse(product.originalPrice) > double.parse(product.price))
          Text(
            'P${product.originalPrice}',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[500],
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onAddToCart,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Pallete.primaryColor,
          side: BorderSide(
            color: Pallete.primaryColor,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
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