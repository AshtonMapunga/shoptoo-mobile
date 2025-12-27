import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandComponent extends StatefulWidget {
  final List<Brand> brands;
  final double height;
  final double itemWidth;
  final double itemSpacing;
  final Color? backgroundColor;
  final double animationSpeed; // pixels per second

  const BrandComponent({
    Key? key,
    required this.brands,
    this.height = 100,
    this.itemWidth = 120,
    this.itemSpacing = 10,
    this.backgroundColor,
    this.animationSpeed = 50, // Default speed: 50 pixels per second
  }) : super(key: key);

  @override
  State<BrandComponent> createState() => _BrandComponentState();
}

class _BrandComponentState extends State<BrandComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _isScrolling = true;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Will be recalculated
    );

    // Start auto-scroll after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    if (widget.brands.isEmpty) return;

    // Calculate total width needed for all items plus spacing
    final totalContentWidth =
        (widget.brands.length * (widget.itemWidth + widget.itemSpacing)) +
        widget.itemSpacing;

    // Calculate animation duration based on speed
    final durationInSeconds = totalContentWidth / widget.animationSpeed;

    _controller.duration = Duration(seconds: durationInSeconds.toInt());

    // Create animation that goes from 0 to total content width
    _animation =
        Tween<double>(begin: 0, end: totalContentWidth).animate(_controller)
          ..addListener(() {
            setState(() {
              _scrollOffset = _animation.value;
              _scrollController.jumpTo(_scrollOffset);
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // Reset to start for seamless loop
              _controller.reset();
              _controller.forward();
            }
          });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.brands.isEmpty) {
      return Container(
        height: widget.height,
        color: widget.backgroundColor,
        child: Center(
          child: Text(
            'No brands available',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          // Main scrollable content
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics:
                const NeverScrollableScrollPhysics(), // Disable manual scroll
            itemCount: widget.brands.length * 2, // Double for seamless loop
            itemBuilder: (context, index) {
              final brandIndex = index % widget.brands.length;
              final brand = widget.brands[brandIndex];

              return Container(
                width: widget.itemWidth,
                margin: EdgeInsets.only(
                  left: index == 0 ? widget.itemSpacing : 0,
                  right: widget.itemSpacing,
                ),
                child: BrandItem(
                  brand: brand,
                  height: widget.height - 20, // Slightly smaller than container
                ),
              );
            },
          ),

          // Gradient overlays for smooth edges (optional)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    widget.backgroundColor ?? Colors.white,
                    (widget.backgroundColor ?? Colors.white).withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    (widget.backgroundColor ?? Colors.white).withOpacity(0.1),
                    widget.backgroundColor ?? Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandItem extends StatelessWidget {
  final Brand brand;
  final double height;

  const BrandItem({Key? key, required this.brand, this.height = 80})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Brand Logo/Image
          Container(
            width: height * 0.9,
            height: height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(
                  brand.imageUrl.isNotEmpty
                      ? brand.imageUrl
                      : 'assets/images/brand_placeholder.png',
                ),
                fit: BoxFit.contain,
              ),
              color: Colors.grey[200],
            ),
          ),

          const SizedBox(height: 8),

          // Brand Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              brand.name,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class Brand {
  final String id;
  final String name;
  final String imageUrl;

  Brand({required this.id, required this.name, required this.imageUrl});
}

// Example usage in your screen:
/*
class HomeScreen extends StatelessWidget {
  final List<Brand> brands = [
    Brand(id: '1', name: 'Nike', imageUrl: 'https://example.com/nike.png'),
    Brand(id: '2', name: 'Adidas', imageUrl: 'https://example.com/adidas.png'),
    Brand(id: '3', name: 'Puma', imageUrl: 'https://example.com/puma.png'),
    Brand(id: '4', name: 'Reebok', imageUrl: 'https://example.com/reebok.png'),
    Brand(id: '5', name: 'New Balance', imageUrl: 'https://example.com/nb.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BrandComponent(
            brands: brands,
            height: 120,
            itemWidth: 100,
            itemSpacing: 20,
            animationSpeed: 40, // Adjust speed as needed
          ),
          // ... other components
        ],
      ),
    );
  }
}
*/
