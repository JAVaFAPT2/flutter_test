import 'package:flutter/material.dart';
import 'custom_bottom_navigation.dart';
import '../../core/constants/figma_assets.dart';

/// Example implementations of CustomBottomNavigation
///
/// This file demonstrates various ways to use the CustomBottomNavigation widget
/// with different configurations and styles.

// ============================================================================
// EXAMPLE 1: Basic Usage (Vietnamese Fish Sauce App Style)
// ============================================================================

class BasicBottomNavigationExample extends StatelessWidget {
  const BasicBottomNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      items: [
        // Left side
        BottomNavItem(
          icon: FigmaAssets.cartIcon,
          width: 34,
          height: 34,
          onTap: () => Navigator.pushNamed(context, '/cart'),
        ),
        BottomNavItem(
          icon: FigmaAssets.ordersIcon,
          width: 58,
          height: 53,
          onTap: () => Navigator.pushNamed(context, '/orders'),
        ),

        // Right side
        BottomNavItem(
          icon: FigmaAssets.notificationsIcon,
          width: 41,
          height: 52,
          badge: 3, // Show notification count
          onTap: () => Navigator.pushNamed(context, '/notifications'),
        ),
        BottomNavItem(
          icon: FigmaAssets.profileIcon,
          width: 53,
          height: 61,
          onTap: () => Navigator.pushNamed(context, '/profile'),
        ),
      ],
      centerItem: CenterNavItem(
        icon: FigmaAssets.homeIcon,
        onTap: () => Navigator.pushNamed(context, '/home'),
        backgroundColor: const Color(0xFF004917), // Dark green
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 2: With Custom Colors
// ============================================================================

class ColoredBottomNavigationExample extends StatelessWidget {
  const ColoredBottomNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      backgroundColor: const Color(0xFFF8F8F8), // Light gray background
      items: [
        BottomNavItem(
          icon: 'assets/icons/search.png',
          onTap: () {},
          selectedColor: const Color(0xFFFF6B6B), // Custom red
        ),
        BottomNavItem(
          icon: 'assets/icons/favorites.png',
          badge: 12,
          badgeColor: const Color(0xFFFF6B6B), // Red badge
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/messages.png',
          badge: 99,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/settings.png',
          onTap: () {},
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/icons/add.png',
        backgroundColor: const Color(0xFFFF6B6B), // Red center button
        onTap: () {},
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 3: E-commerce Style with Badge
// ============================================================================

class EcommerceBottomNavigationExample extends StatefulWidget {
  const EcommerceBottomNavigationExample({super.key});

  @override
  State<EcommerceBottomNavigationExample> createState() =>
      _EcommerceBottomNavigationExampleState();
}

class _EcommerceBottomNavigationExampleState
    extends State<EcommerceBottomNavigationExample> {
  int selectedIndex = 2; // Home selected
  int cartItemCount = 5;
  int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      selectedIndex: selectedIndex,
      items: [
        BottomNavItem(
          icon: 'assets/icons/categories.png',
          width: 35,
          height: 35,
          onTap: () => setState(() => selectedIndex = 0),
        ),
        BottomNavItem(
          icon: 'assets/icons/cart.png',
          width: 40,
          height: 40,
          badge: cartItemCount,
          badgeColor: const Color(0xFFFF5722),
          onTap: () => setState(() => selectedIndex = 1),
        ),
        BottomNavItem(
          icon: 'assets/icons/notifications.png',
          width: 35,
          height: 35,
          badge: notificationCount,
          onTap: () => setState(() => selectedIndex = 3),
        ),
        BottomNavItem(
          icon: 'assets/icons/account.png',
          width: 40,
          height: 40,
          onTap: () => setState(() => selectedIndex = 4),
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/icons/home.png',
        backgroundColor: const Color(0xFF2196F3),
        onTap: () => setState(() => selectedIndex = 2),
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 4: Minimal Style (No Badges)
// ============================================================================

class MinimalBottomNavigationExample extends StatelessWidget {
  const MinimalBottomNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      backgroundColor: Colors.white,
      height: 70, // Shorter height
      items: [
        BottomNavItem(
          icon: 'assets/icons/explore.png',
          width: 28,
          height: 28,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/search.png',
          width: 28,
          height: 28,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/library.png',
          width: 28,
          height: 28,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/profile.png',
          width: 28,
          height: 28,
          onTap: () {},
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/icons/add.png',
        size: 70,
        innerSize: 54,
        iconSize: 32,
        backgroundColor: Colors.black,
        onTap: () {},
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 5: Social Media Style
// ============================================================================

class SocialMediaBottomNavigationExample extends StatelessWidget {
  const SocialMediaBottomNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      backgroundColor: const Color(0xFF1A1A1A), // Dark theme
      items: [
        BottomNavItem(
          icon: 'assets/icons/feed.png',
          width: 30,
          height: 30,
          selectedColor: Colors.white,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/discover.png',
          width: 30,
          height: 30,
          selectedColor: Colors.white,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/inbox.png',
          width: 30,
          height: 30,
          badge: 24,
          badgeColor: const Color(0xFFE91E63),
          selectedColor: Colors.white,
          onTap: () {},
        ),
        BottomNavItem(
          icon: 'assets/icons/me.png',
          width: 30,
          height: 30,
          selectedColor: Colors.white,
          onTap: () {},
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/icons/create.png',
        backgroundColor: const Color(0xFFE91E63), // Pink
        onTap: () {
          // Show create post dialog
        },
      ),
    );
  }
}

// ============================================================================
// EXAMPLE 6: With Navigation Integration
// ============================================================================

class IntegratedBottomNavigationExample extends StatefulWidget {
  const IntegratedBottomNavigationExample({super.key});

  @override
  State<IntegratedBottomNavigationExample> createState() =>
      _IntegratedBottomNavigationExampleState();
}

class _IntegratedBottomNavigationExampleState
    extends State<IntegratedBottomNavigationExample> {
  int _currentIndex = 2;
  final List<Widget> _pages = [
    const Center(child: Text('Cart Page')),
    const Center(child: Text('Orders Page')),
    const Center(child: Text('Home Page')),
    const Center(child: Text('Notifications Page')),
    const Center(child: Text('Profile Page')),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _currentIndex,
        items: [
          BottomNavItem(
            icon: FigmaAssets.cartIcon,
            width: 34,
            height: 34,
            onTap: () => _onNavTap(0),
          ),
          BottomNavItem(
            icon: FigmaAssets.ordersIcon,
            width: 58,
            height: 53,
            onTap: () => _onNavTap(1),
          ),
          BottomNavItem(
            icon: FigmaAssets.notificationsIcon,
            width: 41,
            height: 52,
            badge: 5,
            onTap: () => _onNavTap(3),
          ),
          BottomNavItem(
            icon: FigmaAssets.profileIcon,
            width: 53,
            height: 61,
            onTap: () => _onNavTap(4),
          ),
        ],
        centerItem: CenterNavItem(
          icon: FigmaAssets.homeIcon,
          onTap: () => _onNavTap(2),
          backgroundColor: const Color(0xFF004917),
        ),
      ),
    );
  }
}
