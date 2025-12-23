import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/core/utils/assets_utils.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class CategoryComponent extends StatefulWidget {
  final ValueChanged<int>? onCategorySelected;
  final int initialSelectedIndex;

  const CategoryComponent({
    Key? key,
    this.onCategorySelected,
    this.initialSelectedIndex = 0,
  }) : super(key: key);

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  late int _selectedCategoryIndex;

  // Category data with image paths and titles
  final List<Map<String, String>> _categories = [
   
    {
      'title': 'Fashion',
      'image': 'assets/images/category/fashion.png', 
    },
    {
      'title': 'Electronics',
      'image': 'assets/images/category/electronics.png', 
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/category/appliances.png', 
    },
    {
      'title': 'Furniture',
      'image': 'assets/images/category/furniture.png', 
    }
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

             Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              child: Image.asset(
                Assets.forwardArrow,
                fit: BoxFit.contain,
                height: 25,
              ),
            ),
          ],
        ),

SizedBox(height: 7,),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                  widget.onCategorySelected?.call(index);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      // Category Image
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _selectedCategoryIndex == index
                              ? Pallete.primaryColor 
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          category['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Category Title
                      Text(
                        category['title']!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _selectedCategoryIndex == index
                              ? Pallete.primaryColor 
                              : Colors.grey, 
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}