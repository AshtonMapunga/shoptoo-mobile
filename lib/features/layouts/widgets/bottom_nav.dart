import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/features/cart/screens/cart_screen.dart';
import 'package:shoptoo/features/layouts/screens/home_screen.dart';
import 'package:shoptoo/features/layouts/screens/shop_screen.dart';
import 'package:shoptoo/features/profile/screens/profile_screen.dart';
import 'package:shoptoo/features/wishlist/screens/wishlist_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';


class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  void _handleNavigation(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishlistScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
    
    onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _handleNavigation(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Pallete.secondaryColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax_home),
            activeIcon: Icon(Iconsax_home_15),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax_shop),
            activeIcon: Icon(Iconsax_shop5),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax_heart),
            activeIcon: Icon(Iconsax_heart5),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax_shopping_cart),
            activeIcon: Icon(Iconsax_shopping_cart5),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax_profile_circle),
            activeIcon: Icon(Iconsax_profile_circle5),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Iconsax icons (you should install iconsax package or use your own)
const IconData Iconsax = IconData(0xe900, fontFamily: 'Iconsax');
const IconData Iconsax_home = IconData(0xe901, fontFamily: 'Iconsax');
const IconData Iconsax_home_15 = IconData(0xe902, fontFamily: 'Iconsax');
const IconData Iconsax_shop = IconData(0xe903, fontFamily: 'Iconsax');
const IconData Iconsax_shop5 = IconData(0xe904, fontFamily: 'Iconsax');
const IconData Iconsax_heart = IconData(0xe905, fontFamily: 'Iconsax');
const IconData Iconsax_heart5 = IconData(0xe906, fontFamily: 'Iconsax');
const IconData Iconsax_shopping_cart = IconData(0xe907, fontFamily: 'Iconsax');
const IconData Iconsax_shopping_cart5 = IconData(0xe908, fontFamily: 'Iconsax');
const IconData Iconsax_profile_circle = IconData(0xe909, fontFamily: 'Iconsax');
const IconData Iconsax_profile_circle5 = IconData(0xe90a, fontFamily: 'Iconsax');