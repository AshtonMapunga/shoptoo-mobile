import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialOfferComponent extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const SpecialOfferComponent({
    Key? key,
    this.title = 'Special Offer!',
    this.description = 'Get 20% off on your first order. Limited time offer!',
    this.buttonText = 'Shop Now',
    this.imagePath = 'assets/images/offer.png',
    required this.backgroundColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor.withOpacity(0.9),
            backgroundColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      buttonText,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.local_offer,
                color: Colors.white,
                size: 60,
              );
            },
          ),
        ],
      ),
    );
  }
}