import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/core/utils/assets_utils.dart';
import 'package:shoptoo/features/welcome/screens/onboarding_page.dart';
import 'package:shoptoo/shared/themes/colors.dart';


class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<OnBoardingItem> onboardingItems = [
    OnBoardingItem(
      imagePath: Assets.smarter,
      title: 'Shop Smarter, Anytime',
      subtitle: 'Discover quality products, great prices, and fast delivery—all in one place.',
      titleColor: Pallete.lightPrimaryTextColor,
      subtitleColor: Pallete.lightPrimaryTextColor,
    ),
    OnBoardingItem(
      imagePath: Assets.fast,
      title: 'Fast. Easy. Reliable.',
      subtitle: 'Find what you love and get it delivered without hassle.',
      titleColor: Pallete.lightPrimaryTextColor,
      subtitleColor: Pallete.lightPrimaryTextColor,
    ),
    OnBoardingItem(
      imagePath: Assets.local,
      title: 'Shop Local. Shop Smart.',
      subtitle: 'Quality products from trusted sellers, delivered to your door.',
      titleColor: Pallete.lightPrimaryTextColor,
      subtitleColor: Pallete.lightPrimaryTextColor,
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return OnBoardingPage(
      items: onboardingItems,
      backgroundColor: Pallete.fedColor,
      nextButtonColor: Pallete.primaryColor,
      titleColor: Pallete.lightPrimaryTextColor,
      subtitleColor: Pallete.lightPrimaryTextColor,
    );
  }
}

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Pallete.fedColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(Assets.smarter),
            ),
            const SizedBox(height: 24), 
            
            Text(
              'Shop Smarter, Anytime',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 24, 
              ),
            ),
            const SizedBox(height: 8),
            
            Text(
              'Discover quality products, great prices, and fast delivery—all in one place.',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Pallete.fedColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(Assets.fast),
            ),
            const SizedBox(height: 24), 
            
            Text(
              'Fast. Easy. Reliable.',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 24, 
              ),
            ),
            const SizedBox(height: 8),
            
            Text(
              'Find what you love and get it delivered without hassle.',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Pallete.fedColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(Assets.local),
            ),
            const SizedBox(height: 24), 
            
            Text(
              'Shop Local. Shop Smart.',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 24, 
              ),
            ),
            const SizedBox(height: 8),
            
            Text(
              'Quality products from trusted sellers, delivered to your door.',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

