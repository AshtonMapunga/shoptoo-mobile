import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerList extends StatelessWidget {
  final int itemCount;
  final double height;
  final EdgeInsetsGeometry padding;

  const CategoryShimmerList({
    super.key,
    this.itemCount = 5,
    this.height = 70,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return _buildShimmerItem();
          },
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon placeholder
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 6),
          // Text placeholder
          Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}