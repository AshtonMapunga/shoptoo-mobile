import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class ProductCardComponent extends StatelessWidget {
  final ProductEntity product;
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
    this.imageHeight = 138,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceValue = double.tryParse(product.price) ?? 0;
    final regularPriceValue = double.tryParse(product.regularPrice) ?? 0;
    final discount = regularPriceValue > 0
        ? ((regularPriceValue - priceValue) / regularPriceValue * 100).round()
        : 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 14),
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
            _buildProductImage(discount),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    _buildRating(),
                    _buildPrice(discount),
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

  Widget _buildProductImage(int discount) {
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
              product.image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.shopping_bag, size: 50),
                );
              },
            ),
          ),
        ),
        if (discount > 0)
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
                '$discount% OFF',
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (product.featured)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Featured',
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
            ),
          ),
        if (product.isNew)
          Positioned(
            top: product.featured ? 30 : 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'New',
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 10),
        const SizedBox(width: 4),
        Text(
          product.rating.toStringAsFixed(1),
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

  Widget _buildPrice(int discount) {
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
        if (discount > 0)
          Text(
            'P${product.regularPrice}',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color:  Colors.grey[500],
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
          padding: const EdgeInsets.symmetric(vertical: 4),
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




