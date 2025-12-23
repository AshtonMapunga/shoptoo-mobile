import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreativeSlider extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final double borderRadius;
  final BoxFit fit;
  final Duration autoPlayInterval;
  final bool autoPlay;
  final Color activeDotColor;
  final Color inactiveDotColor;
  final double dotWidth;
  final double dotHeight;
  final double dotSpacing;
  final bool showShadow;
  final VoidCallback? onTap;

  const CreativeSlider({
    Key? key,
    required this.imageUrls,
    this.height = 200,
    this.borderRadius = 20,
    this.fit = BoxFit.cover,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlay = true,
    this.activeDotColor = Colors.white,
    this.inactiveDotColor = Colors.white54,
    this.dotWidth = 20,
    this.dotHeight = 4,
    this.dotSpacing = 6,
    this.showShadow = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<CreativeSlider> createState() => _CreativeSliderState();
}

class _CreativeSliderState extends State<CreativeSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.autoPlay && widget.imageUrls.length > 1) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
  }

  void _restartAutoPlay() {
    _stopAutoPlay();
    if (widget.autoPlay && widget.imageUrls.length > 1) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onDotTap(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    _restartAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Container
        GestureDetector(
          onTap: widget.onTap,
          onPanDown: (_) => _stopAutoPlay(),
          onPanEnd: (_) => _restartAutoPlay(),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.showShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Stack(
                children: [
                  // PageView for images
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: widget.imageUrls.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }

                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: _buildImage(widget.imageUrls[index]),
                      );
                    },
                  ),

                  // Gradient overlay at bottom for better dot visibility
                  if (widget.imageUrls.length > 1)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Page indicator positioned at bottom
                  if (widget.imageUrls.length > 1)
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: _buildPageIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[200]!,
          ],
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: widget.fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey[500],
                ),
                SizedBox(height: 8),
                Text(
                  'Failed to load image',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imageUrls.length, (index) {
        return GestureDetector(
          onTap: () => _onDotTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _currentPage == index ? widget.dotWidth * 1.5 : widget.dotWidth,
            height: widget.dotHeight,
            margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing / 2),
            decoration: BoxDecoration(
              color: _currentPage == index
                  ? widget.activeDotColor
                  : widget.inactiveDotColor,
              borderRadius: BorderRadius.circular(widget.dotHeight / 2),
              boxShadow: [
                if (_currentPage == index)
                  BoxShadow(
                    color: widget.activeDotColor.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}