import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoptoo/features/cart/presentation/providers/cart_providers.dart';
import 'package:shoptoo/features/cart/screens/cart_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class SearchBarWithCart extends ConsumerStatefulWidget {
  const SearchBarWithCart({super.key});

  @override
  ConsumerState<SearchBarWithCart> createState() => _SearchBarWithCartState();
}

class _SearchBarWithCartState extends ConsumerState<SearchBarWithCart> {
  bool _repeatCartAnimation = true;
  Timer? _repeatTimer;

  void _navigateToSearchScreen() {
    // Implement your search navigation
  }

  void _triggerCartAnimation() {
    setState(() => _repeatCartAnimation = true);

    // Stop after 5 seconds
    _repeatTimer?.cancel();
    _repeatTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _repeatCartAnimation = false);
    });
  }

  @override
  void dispose() {
    _repeatTimer?.cancel();
    super.dispose();
  }
@override
Widget build(BuildContext context) {
  final cartItems = ref.watch(cartControllerProvider).asData?.value ?? [];
  final int cartItemCount =
      cartItems.fold<int>(0, (prev, item) => prev + item.quantity);

  // Trigger animation when cart count increases
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (cartItemCount > 0 && !_repeatCartAnimation) {
      _repeatCartAnimation = true;

      _repeatTimer?.cancel();
      _repeatTimer = Timer(const Duration(seconds: 5), () {
        if (mounted) setState(() => _repeatCartAnimation = false);
      });
    }
  });

  return Container(
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        // Search box
        Expanded(
          child: GestureDetector(
            onTap: _navigateToSearchScreen,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.search,
                    color:
                        Pallete.lightPrimaryTextColor.withOpacity(0.5),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search Shoptoo!',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Pallete.lightPrimaryTextColor
                            .withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Cart icon with badge
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CartScreen()),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Pallete.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Lottie.asset(
                  'assets/animations/cart.json',
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                  repeat: _repeatCartAnimation,
                ),
              ),
            ),
            if (cartItemCount > 0)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Text(
                      cartItemCount > 9 ? '9+' : '$cartItemCount',
                      key: ValueKey<int>(cartItemCount),
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

}
