// In your HomeScreen file, add this import at the top:

// And update your sampleProducts list to:
import 'package:shoptoo/shared/widgets/cards/product_card.dart';

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