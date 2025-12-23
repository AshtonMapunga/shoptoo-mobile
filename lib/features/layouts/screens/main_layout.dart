import 'package:flutter/material.dart';
import 'package:shoptoo/features/layouts/widgets/app_header.dart';
import 'package:shoptoo/features/layouts/widgets/bottom_nav.dart';

class MainLayout extends StatefulWidget {
  final Widget body;
  final String title;
  final bool showBackButton;
  final bool showSearchBar;
  final bool showHeader;
  final bool showBottomNavigation;
  final VoidCallback? onBackPressed;
  final String? searchHint;
  final Widget? customHeader;
  final int initialTabIndex;
  final List<String>? headerButtons;

  const MainLayout({
    super.key,
    required this.body,
    this.title = '',
    this.showBackButton = false,
    this.showSearchBar = false,
    this.showHeader = true,
    this.showBottomNavigation = true,
    this.onBackPressed,
    this.searchHint,
    this.customHeader,
    this.initialTabIndex = 0,
    this.headerButtons,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex;
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: 
           PreferredSize(
              preferredSize: const Size.fromHeight(140.0),
              child: 
                 AppHeader(
        showSearchBar: true,
        searchHint: 'Search Shoptoo!',
      ),
            ),
      body: SafeArea(
        child: Column(
          children: [

          

            // Body
            Expanded(
              child: widget.body,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNavigation
          ? BottomNavigation(
              currentIndex: _currentTabIndex,
              onTabChanged: _onTabChanged,
            )
          : null,
    );
  }
}