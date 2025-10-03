import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable bottom navigation bar with elevated center button
///
/// Features:
/// - 5 navigation items (2 left, 1 center elevated, 2 right)
/// - Customizable icons, colors, and callbacks
/// - Optional badge support for notifications
/// - Elevated center home button with custom styling
/// - Fully responsive and reusable
///
/// Example usage:
/// ```dart
/// CustomBottomNavigation(
///   items: [
///     BottomNavItem(icon: 'assets/cart.png', onTap: () => navigateToCart()),
///     BottomNavItem(icon: 'assets/orders.png', onTap: () => navigateToOrders()),
///     BottomNavItem(icon: 'assets/notifications.png', badge: 3),
///     BottomNavItem(icon: 'assets/profile.png'),
///   ],
///   centerItem: CenterNavItem(
///     icon: 'assets/home.png',
///     onTap: () => navigateToHome(),
///     backgroundColor: Color(0xFF004917),
///   ),
/// )
/// ```
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.items,
    required this.centerItem,
    this.backgroundColor = Colors.white,
    this.height = 95.0,
    this.selectedIndex = 2, // Center home button by default
  });

  /// List of 4 navigation items (2 for left, 2 for right of center button)
  /// Items will be displayed as: [item[0], item[1], CENTER, item[2], item[3]]
  final List<BottomNavItem> items;

  /// The elevated center navigation item (usually Home)
  final CenterNavItem centerItem;

  /// Background color of the navigation bar
  final Color backgroundColor;

  /// Height of the navigation bar
  final double height;

  /// Currently selected index (0-4, where 2 is center)
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    assert(
        items.length == 4, 'CustomBottomNavigation requires exactly 4 items');

    return SafeArea(
      top: false,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Bottom navigation items
            Row(
              children: [
                // Left items (equal space each)
                Expanded(child: Align(child: _buildNavItem(items[0], 0))),
                Expanded(child: Align(child: _buildNavItem(items[1], 1))),

                // Spacer for center button
                SizedBox(width: centerItem.size),

                // Right items (equal space each)
                Expanded(child: Align(child: _buildNavItem(items[2], 3))),
                Expanded(child: Align(child: _buildNavItem(items[3], 4))),
              ],
            ),

            // Center button positioned within the navigation bar bounds
            Positioned(
              left: (MediaQuery.of(context).size.width - centerItem.size) / 2,
              top: (height - centerItem.size) /
                  2, // Center vertically within the bar
              child: _buildCenterButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BottomNavItem item, int index) {
    final isSelected = selectedIndex == index;
    final double displayWidth = item.width * item.scale;
    final double displayHeight = item.height * item.scale;

    return GestureDetector(
      onTap: item.onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: displayWidth + 4, // tighter padding to avoid overflow
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Icon
            _buildAssetIcon(
              path: item.icon,
              width: displayWidth,
              height: displayHeight,
              color: isSelected ? item.selectedColor : item.color,
            ),

            // Badge
            if (item.badge != null && item.badge! > 0)
              Positioned(
                right: 10,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: item.badgeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    item.badge! > 99 ? '99+' : item.badge.toString(),
                    style: TextStyle(
                      fontSize: item.badge! > 99 ? 8 : 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: centerItem.onTap,
      child: Container(
        width: centerItem.size,
        height: centerItem.size,
        decoration: BoxDecoration(
          color: centerItem.outerColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner circle
            Container(
              width: centerItem.innerSize,
              height: centerItem.innerSize,
              decoration: BoxDecoration(
                color: centerItem.backgroundColor,
                shape: BoxShape.circle,
              ),
            ),
            // Icon
            _buildAssetIcon(
              path: centerItem.icon,
              width: centerItem.iconSize,
              height: centerItem.iconSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetIcon({
    required String path,
    required double width,
    required double height,
    Color? color,
  }) {
    final isSvg = path.toLowerCase().endsWith('.svg');
    if (isSvg) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.contain,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    }
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.contain,
      color: color,
      filterQuality: FilterQuality.high,
      isAntiAlias: true,
      errorBuilder: (context, error, stack) {
        // Fallback for missing/renamed assets
        return Icon(
          Icons.home_filled,
          size: width < height ? width : height,
          color: color ?? Colors.white,
        );
      },
    );
  }
}

/// Configuration for a standard bottom navigation item
class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    this.width = 40,
    this.height = 40,
    this.scale = 1.0,
    this.onTap,
    this.badge,
    this.badgeColor = const Color(0xFFC80000),
    this.color,
    this.selectedColor = const Color(0xFF004917),
  });

  /// Asset path for the icon
  final String icon;

  /// Width of the icon
  final double width;

  /// Height of the icon
  final double height;

  /// Multiplier to scale icon rendering size without changing base dimensions
  final double scale;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Optional badge count (null or 0 = no badge)
  final int? badge;

  /// Badge background color
  final Color badgeColor;

  /// Default icon color
  final Color? color;

  /// Icon color when selected
  final Color selectedColor;
}

/// Configuration for the elevated center navigation item
class CenterNavItem {
  const CenterNavItem({
    required this.icon,
    this.onTap,
    this.size = 89,
    this.innerSize = 67,
    this.iconSize = 37,
    this.backgroundColor = const Color(0xFF004917),
    this.outerColor = Colors.white,
  });

  /// Asset path for the icon
  final String icon;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Outer circle size
  final double size;

  /// Inner colored circle size
  final double innerSize;

  /// Icon size
  final double iconSize;

  /// Background color of the inner circle
  final Color backgroundColor;

  /// Color of the outer white circle
  final Color outerColor;
}
