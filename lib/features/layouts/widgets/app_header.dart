import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class AppHeader extends StatefulWidget {
  final String title;
  final bool showBackButton;
  final bool showSearchBar;
  final VoidCallback? onBackPressed;
  final String? searchHint;
  final List<String>? buttons;
  final bool expanded;
  final double expandedHeight;

  const AppHeader({
    super.key,
    this.title = '',
    this.showBackButton = false,
    this.showSearchBar = false,
    this.onBackPressed,
    this.searchHint,
    this.buttons,
    this.expanded = false,
    this.expandedHeight = 160.0,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _showSearchOnly = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.expanded) {
      _scrollController.addListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    if (widget.expanded) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 100 && !_showSearchOnly) {
      setState(() {
        _showSearchOnly = true;
      });
    } else if (_scrollController.offset <= 100 && _showSearchOnly) {
      setState(() {
        _showSearchOnly = false;
      });
    }
  }

  Widget _buildSearchBar() {
    return Column(
      children: [
        _buildTopMarket(),
        SizedBox(height: 12),

        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.search,
                color: Pallete.lightPrimaryTextColor.withOpacity(0.5),
                size: 18,
              ),

              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Pallete.lightPrimaryTextColor,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.searchHint ?? 'Search...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Pallete.lightPrimaryTextColor.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsRow() {
    if (widget.buttons == null || widget.buttons!.isEmpty) {
      return Container();
    }

    return Row(
      children: widget.buttons!.asMap().entries.map((entry) {
        final index = entry.key;
        final buttonText = entry.value;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(left: index > 0 ? 10 : 0),
            child: OutlinedButton(
              onPressed: () {
                // Handle button press
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: Pallete.lightPrimaryTextColor.withOpacity(0.3),
                ),
                backgroundColor: index == 0 ? Colors.yellow : Colors.white,
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Pallete.lightPrimaryTextColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTopMarket() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buttons Row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle  button
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    backgroundColor: Colors.yellow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/logo_icon.png',
                        height: 28,
                        width: 28,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_bag,
                            size: 20,
                            color: Colors.black,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Shoptoo',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Buy Online button
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/onlinebuy.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_cart,
                            size: 20,
                            color: Colors.black,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Deliver button
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/deliver.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.local_shipping,
                            size: 20,
                            color: Colors.black,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'We Deliver',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Search bar
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expanded) {
      return SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        pinned: true,
        floating: false,
        snap: false,
        automaticallyImplyLeading: false,
        expandedHeight: widget.expandedHeight,
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              titlePadding: const EdgeInsets.all(0),
              expandedTitleScale: 1.0,
              title: _showSearchOnly && widget.showSearchBar
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10,
                      ),
                      child: _buildSearchBar(),
                    )
                  : null,
              background: _buildExpandedHeader(),
            );
          },
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Column(
        children: [
          // Title and Back Button Row
          Row(
            children: [
              if (widget.showBackButton)
                IconButton(
                  onPressed:
                      widget.onBackPressed ?? () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Pallete.lightPrimaryTextColor,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              if (widget.title.isNotEmpty) ...[
                if (widget.showBackButton) const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Pallete.lightPrimaryTextColor,
                  ),
                ),
              ],
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),

          // Buttons Row (if provided)
          if (widget.buttons != null && widget.buttons!.isNotEmpty) ...[
            _buildButtonsRow(),
            const SizedBox(height: 16),
          ],

          // Search Bar
          if (widget.showSearchBar) _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildExpandedHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // Buttons Row
          if (widget.buttons != null && widget.buttons!.isNotEmpty) ...[
            _buildButtonsRow(),
            const SizedBox(height: 16),
          ],

          // Search bar
          if (widget.showSearchBar) _buildSearchBar(),
        ],
      ),
    );
  }
}

// Add this import for Iconsax
const IconData Iconsax = IconData(0xe900, fontFamily: 'Iconsax');
