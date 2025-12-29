import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/core/utils/assets_utils.dart';
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';
import 'package:shoptoo/shared/widgets/cards/product_card.dart';

class ProductsComponent extends StatelessWidget {
  final String title;
  final String seeAllText;
  final VoidCallback? onSeeAllPressed;
  final List<ProductEntity> products;
  final ValueChanged<ProductEntity>? onProductPressed;
  final ValueChanged<ProductEntity>? onAddToCart;
  final ValueChanged<ProductEntity>? onAddToWishlist;

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
              return ProductCardComponent(
                product: product,
                onTap: () => onProductPressed?.call(product),
                onAddToCart: () => onAddToCart?.call(product),
                onAddToWishlist: () => onAddToWishlist?.call(product),
                width: 160,
                imageHeight: 140,
              );
            },
          ),
        ),
      ],
    );
  }
}

// Remove the duplicate Product class and sampleProducts list from here
// since they're now defined in product_card_component.dart