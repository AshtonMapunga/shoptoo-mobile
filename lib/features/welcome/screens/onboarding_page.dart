import 'package:flutter/material.dart';
import 'package:shoptoo/core/utils/helpers.dart';
import 'package:shoptoo/features/auth/screens/login_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  final List<OnBoardingItem> items;
  final Color backgroundColor;
  final Color skipTextColor;
  final Color doneTextColor;
  final Color pageIndicatorColor;
  final Color activePageIndicatorColor;
  final Color nextButtonColor;
  final Color titleColor;
  final Color subtitleColor;
  final bool showSkipButton;
  final String skipText;
  final String doneText;

  const OnBoardingPage({
    super.key,
    required this.items,
    this.backgroundColor = Colors.white,
    this.skipTextColor = Colors.black,
    this.doneTextColor = Colors.black,
    this.pageIndicatorColor = Colors.white,
    this.activePageIndicatorColor = Colors.blue,
    this.nextButtonColor = Colors.blue,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.black,
    this.showSkipButton = true,
    this.skipText = 'Skip',
    this.doneText = 'Done',
  }) : assert(items.length >= 2, 'At least 2 pages are required');

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == widget.items.length - 1;
    
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(widget.items[index]);
            },
          ),
          
          // Bottom Controls
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button (hidden on last page)
                  if (widget.showSkipButton && !isLastPage)
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(widget.items.length - 1);
                      },
                      child: Text(
                        widget.skipText,
                        style: TextStyle(
                          color: widget.skipTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 40),

                  // Page Indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: widget.items.length,
                    effect: WormEffect(
                      spacing: 8.0,
                      dotWidth: 8,
                      dotHeight: 8,
                      dotColor: widget.pageIndicatorColor,
                      activeDotColor: widget.activePageIndicatorColor,
                    ),
                  ),

                  // Next/Done Button
                  GestureDetector(
                    onTap: () {
                      if (isLastPage) {
                        GeneralHelpers.permanentNavigator(
                            context, const LoginScreen());
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: widget.nextButtonColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.nextButtonColor.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        isLastPage ? Icons.check : Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnBoardingItem item) {
    return Container(
      color: widget.backgroundColor,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Center(
              child: item.customImage ?? Image.asset(
                item.imagePath,
                height: item.imageHeight,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Title
          Text(
            item.title,
            style: TextStyle(
              color: item.titleColor ?? widget.titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              height: 1.2,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Subtitle
          Text(
            item.subtitle,
            style: TextStyle(
              color: item.subtitleColor ?? widget.subtitleColor,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 60), // Space for bottom controls
        ],
      ),
    );
  }
}

// OnBoardingItem model class
class OnBoardingItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget? customImage;
  final double imageHeight;

  const OnBoardingItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    this.titleColor,
    this.subtitleColor,
    this.customImage,
    this.imageHeight = 300,
  });
}