import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shoptoo/features/layouts/screens/main_layout.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data
  final Map<String, dynamic> _userData = {
    'name': 'Thabo Moloi',
    'email': 'thabo.moloi@email.com',
    'phone': '+267 71 234 567',
    'joinedDate': 'January 2024',
    'location': 'Gaborone, Botswana',
    'profileImage': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face',
  };

  final List<ProfileMenuItem> _menuItems = [
    ProfileMenuItem(
      title: 'My Orders',
      icon: Iconsax.shopping_bag,
      color: Colors.blue,
      count: 3,
    ),
    ProfileMenuItem(
      title: 'My Addresses',
      icon: Iconsax.location,
      color: Colors.green,
    ),
    ProfileMenuItem(
      title: 'Payment Methods',
      icon: Iconsax.card,
      color: Colors.purple,
    ),
    ProfileMenuItem(
      title: 'My Reviews',
      icon: Iconsax.star,
      color: Colors.amber,
      count: 12,
    ),
    ProfileMenuItem(
      title: 'Settings',
      icon: Iconsax.setting,
      color: Colors.grey,
    ),
    ProfileMenuItem(
      title: 'Help & Support',
      icon: Iconsax.message_question,
      color: Colors.orange,
    ),
    ProfileMenuItem(
      title: 'About Us',
      icon: Iconsax.info_circle,
      color: Colors.red,
    ),
  ];

  final List<OrderStats> _orderStats = [
    OrderStats(status: 'Pending', count: 2, color: Colors.orange),
    OrderStats(status: 'Delivered', count: 8, color: Colors.green),
    OrderStats(status: 'Cancelled', count: 1, color: Colors.red),
  ];

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Iconsax.close_circle),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Add your edit profile form here
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildEditProfileField('Full Name', _userData['name']),
                      _buildEditProfileField('Email', _userData['email']),
                      _buildEditProfileField('Phone', _userData['phone']),
                      _buildEditProfileField('Location', _userData['location']),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileField(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Pallete.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuAction(ProfileMenuItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${item.title}'),
        backgroundColor: Pallete.primaryColor,
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigate to login screen
            },
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      initialTabIndex: 4,
      body: Stack(
        children: [
          // Background animated circles
          _buildBackgroundCircles(),
          
          // Main content
          CustomScrollView(
            slivers: [
              // App Bar with animation
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                floating: true,
                expandedHeight: 70,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Animated half circles
                      Positioned(
                        top: -50,
                        right: -50,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeInOut,
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Pallete.secondaryColor.withOpacity(0.15),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Secondary circle
                      Positioned(
                        top: -30,
                        right: -30,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 1800),
                          curve: Curves.easeInOut,
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Pallete.secondaryColor.withOpacity(0.1),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                title: AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Iconsax.setting, color: Colors.black),
                    onPressed: () => _showMenuAction(_menuItems[4]), // Settings
                  ),
                ],
              ),

              // Profile Header
              SliverToBoxAdapter(
                child: _buildProfileHeader(),
              ),

            

              // Menu Items
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildMenuItem(_menuItems[index]);
                  },
                  childCount: _menuItems.length,
                ),
              ),

              // Logout Button
              SliverToBoxAdapter(
                child: _buildLogoutButton(),
              ),

              // Bottom Spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
            ],
          ),
        ],
      ), appBar: null,
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        // Top right animated half circle
        Positioned(
          top: -100,
          right: -100,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.15),
                  ),
                ),
              );
            },
          ),
        ),
        // Secondary top right circle
        Positioned(
          top: -80,
          right: -80,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
        // Bottom left animated half circle
        Positioned(
          bottom: -100,
          left: -100,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.15),
                  ),
                ),
              );
            },
          ),
        ),
        // Secondary bottom left circle
        Positioned(
          bottom: -80,
          left: -80,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.secondaryColor.withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Pallete.primaryColor, width: 3),
              image: DecorationImage(
                image: NetworkImage(_userData['profileImage']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userData['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _userData['email'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Member since ${_userData['joinedDate']}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          
          // Edit Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Pallete.primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Iconsax.edit, color: Colors.white, size: 18),
              onPressed: _editProfile,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMenuItem(ProfileMenuItem item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showMenuAction(item),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (item.count != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.count.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: item.color,
                      ),
                    ),
                  ),
                SizedBox(width: 8),
                Icon(
                  Iconsax.arrow_right_3,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: OutlinedButton(
        onPressed: _logout,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: Colors.red),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.logout, color: Colors.red, size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final int? count;

  ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.color,
    this.count,
  });
}

class OrderStats {
  final String status;
  final int count;
  final Color color;

  OrderStats({
    required this.status,
    required this.count,
    required this.color,
  });
}