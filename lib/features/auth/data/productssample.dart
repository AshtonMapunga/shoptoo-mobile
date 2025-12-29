// In your HomeScreen file, add this import at the top:

// And update your sampleProducts list to:
import 'package:shoptoo/features/products/domain/entities/product_entity.dart';

final List<ProductEntity> sampleProducts = [
  ProductEntity(
    name: 'Wireless Bluetooth ',
    price: '199.99',
    regularPrice: '249.99',
    image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop',
    rating: 4.5,
    reviewCount: 128,
    featured: true,
    isNew: true,
    id: 1,

    
  ),
  ProductEntity(
    name: 'Modern Office Chair',
    price: '299.99',
    regularPrice: '399.99',
    image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
    rating: 4.8,
    reviewCount: 89,
    featured: true,
    isNew: false, id: 2,
  ),
  ProductEntity(
    name: 'Running Shoes',
    price: '129.99',
    regularPrice: '159.99',
    image: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=300&fit=crop',
    rating: 4.3,
    reviewCount: 256,
    featured: false,
    isNew: true, id:  3,
  ),
  
];