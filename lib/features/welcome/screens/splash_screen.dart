import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shoptoo/core/utils/assets_utils.dart';
import 'package:shoptoo/features/welcome/screens/onboarding_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with decorative half circles
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Pallete.fedColor,
            child: Stack(
              children: [
                // Top left half circle
                Positioned(
                  top: -100,
                  left: -100,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.fedColor.withOpacity(0.3),
                    ),
                  ),
                ),
                // Secondary top left circle for depth
                Positioned(
                  top: -80,
                  left: -80,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.fedColor.withOpacity(0.1),
                    ),
                  ),
                ),
                // Bottom right half circle
                Positioned(
                  bottom: -100,
                  right: -100,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade200.withOpacity(0.3),
                    ),
                  ),
                ),
                // Secondary bottom right circle for depth
                Positioned(
                  bottom: -80,
                  right: -80,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.fedColor.withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Animated splash screen content
          AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Pallete.primaryColor.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(Assets.logoIcon),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Truly African',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Marketplace',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            nextScreen: OnBoardingScreen(),
            splashIconSize: 300,
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutCubic,
          ),
        ],
      ),
    );
  }
}

