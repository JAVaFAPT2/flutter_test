import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import removed: using direct SVG asset paths for consistent sizing
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_bottom_navigation.dart';

/// Bottom navigation bar for the app using CustomBottomNavigation widget
class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      items: [
        BottomNavItem(
          icon: 'assets/figma_exports/cart_icon.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () => context.push('/cart'),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/menu_box.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () => context.push('/order-history'),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/bell_menu.png',
          width: 40,
          height: 40,
          scale: 1.0,
          badge: 1,
          onTap: () {
            // NOTE: Navigate to notifications page when implemented
          },
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/profile_menu.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () => context.push('/profile'),
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/figma_exports/home_menu.png',
        size: 75,
        innerSize: 55,
        iconSize: 30,
        onTap: () {
          // Already on home - could scroll to top or refresh
        },
        backgroundColor: const Color(0xFF004917), // Dark green
      ),
      height: 80.0, // Reduced height
      selectedIndex: 2, // Home is selected
    );
  }
}
