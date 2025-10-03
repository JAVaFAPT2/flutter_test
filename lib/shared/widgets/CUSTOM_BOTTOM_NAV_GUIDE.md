# Custom Bottom Navigation Menu - Complete Guide

**Based on Figma Design:** [Vietnamese Fish Sauce App](https://www.figma.com/design/DTsoPQ2H2y71hG7ftpTQZk/Untitled?node-id=1-2896&m=dev)

## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Customization](#customization)
- [Examples](#examples)
- [API Reference](#api-reference)
- [Design Specifications](#design-specifications)

---

## 🎯 Overview

A highly customizable Flutter bottom navigation bar widget featuring:
- 5 navigation items (2 left, 1 elevated center, 2 right)
- Elevated circular center button with drop shadow
- Badge support for notifications
- Fully responsive and pixel-perfect
- Easy to integrate and customize

### Visual Structure

```
┌─────────────────────────────────────────┐
│                                         │
│              ╱────────╲                 │  ← Elevated Center Button
│             │   HOME   │                │
│             ╲────────╱                  │
├────┬────┬────┴────┴────┬────┬──────────┤
│    │    │              │    │          │
│ 🛒 │ 📦 │              │ 🔔 │    👤    │  ← Bottom Bar (95px)
│    │    │              │    │          │
└────┴────┴──────────────┴────┴──────────┘
```

---

## ✨ Features

### Core Features
- ✅ **5-Item Layout**: Perfect for primary navigation patterns
- ✅ **Elevated Center Button**: Distinctive home/primary action button
- ✅ **Badge Support**: Show notification counts (1-99+)
- ✅ **Customizable Colors**: Match any brand color scheme
- ✅ **Flexible Sizing**: Adjust heights, icon sizes, and button dimensions
- ✅ **Tap Callbacks**: Individual tap handlers for each item
- ✅ **Selection State**: Visual feedback for active items
- ✅ **Shadow Effects**: Professional depth and elevation

### Design Features
- 📱 Responsive layout
- 🎨 Figma-accurate implementation
- 🚀 Performance optimized
- 🔧 Zero external dependencies (except Flutter)
- 📝 Comprehensive documentation
- 🧩 Modular and reusable

---

## 📦 Installation

### Step 1: Copy Files

Copy these files to your project:
```
lib/shared/widgets/
├── custom_bottom_navigation.dart
├── custom_bottom_navigation_example.dart
└── CUSTOM_BOTTOM_NAV_GUIDE.md (this file)
```

### Step 2: Import

```dart
import 'package:your_app/shared/widgets/custom_bottom_navigation.dart';
```

### Step 3: Add Assets

Ensure your navigation icons are added to `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/icons/
    - assets/figma_exports/
```

---

## 🚀 Basic Usage

### Minimal Example

```dart
CustomBottomNavigation(
  items: [
    BottomNavItem(icon: 'assets/icons/cart.png', onTap: () {}),
    BottomNavItem(icon: 'assets/icons/orders.png', onTap: () {}),
    BottomNavItem(icon: 'assets/icons/notifications.png', onTap: () {}),
    BottomNavItem(icon: 'assets/icons/profile.png', onTap: () {}),
  ],
  centerItem: CenterNavItem(
    icon: 'assets/icons/home.png',
    onTap: () {},
  ),
)
```

### Complete Scaffold Example

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YourContentHere(),
      bottomNavigationBar: CustomBottomNavigation(
        items: [
          BottomNavItem(
            icon: 'assets/icons/cart.png',
            width: 34,
            height: 34,
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
          BottomNavItem(
            icon: 'assets/icons/orders.png',
            width: 58,
            height: 53,
            onTap: () => Navigator.pushNamed(context, '/orders'),
          ),
          BottomNavItem(
            icon: 'assets/icons/notifications.png',
            width: 41,
            height: 52,
            badge: 5, // Show notification count
            onTap: () => Navigator.pushNamed(context, '/notifications'),
          ),
          BottomNavItem(
            icon: 'assets/icons/profile.png',
            width: 53,
            height: 61,
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
        centerItem: CenterNavItem(
          icon: 'assets/icons/home.png',
          onTap: () => Navigator.pushNamed(context, '/home'),
          backgroundColor: Color(0xFF004917),
        ),
      ),
    );
  }
}
```

---

## 🎨 Customization

### Custom Colors

```dart
CustomBottomNavigation(
  backgroundColor: Color(0xFFF8F8F8), // Bar background
  items: [
    BottomNavItem(
      icon: 'assets/icons/search.png',
      selectedColor: Color(0xFFFF6B6B), // When selected
      badgeColor: Color(0xFFFF0000), // Badge color
      badge: 10,
      onTap: () {},
    ),
    // ... more items
  ],
  centerItem: CenterNavItem(
    icon: 'assets/icons/add.png',
    backgroundColor: Color(0xFFFF6B6B), // Inner circle
    outerColor: Colors.white, // Outer circle
    onTap: () {},
  ),
)
```

### Custom Sizes

```dart
CustomBottomNavigation(
  height: 80, // Bar height
  items: [
    BottomNavItem(
      icon: 'assets/icons/icon.png',
      width: 32, // Icon width
      height: 32, // Icon height
      onTap: () {},
    ),
    // ... more items
  ],
  centerItem: CenterNavItem(
    icon: 'assets/icons/home.png',
    size: 70, // Outer circle size
    innerSize: 54, // Inner circle size
    iconSize: 32, // Icon size
    onTap: () {},
  ),
)
```

### With Badge

```dart
BottomNavItem(
  icon: 'assets/icons/notifications.png',
  badge: 12, // Number to display
  badgeColor: Color(0xFFC80000), // Red badge
  onTap: () {},
)

// For 99+ notifications:
BottomNavItem(
  icon: 'assets/icons/messages.png',
  badge: 150, // Will display as "99+"
  onTap: () {},
)
```

### Selection State

```dart
class _MyPageState extends State<MyPage> {
  int _selectedIndex = 2; // Home selected

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      selectedIndex: _selectedIndex,
      items: [
        BottomNavItem(
          icon: 'assets/icons/item1.png',
          onTap: () => setState(() => _selectedIndex = 0),
        ),
        // ... more items
      ],
      centerItem: CenterNavItem(
        icon: 'assets/icons/home.png',
        onTap: () => setState(() => _selectedIndex = 2),
      ),
    );
  }
}
```

---

## 📖 Examples

### Example 1: E-commerce App (Vietnamese Fish Sauce Style)

```dart
CustomBottomNavigation(
  items: [
    BottomNavItem(
      icon: 'assets/figma_exports/cart.png',
      width: 34,
      height: 34,
      onTap: () => navigateToCart(),
    ),
    BottomNavItem(
      icon: 'assets/figma_exports/orders.png',
      width: 58,
      height: 53,
      badge: 2,
      onTap: () => navigateToOrders(),
    ),
    BottomNavItem(
      icon: 'assets/figma_exports/notifications.png',
      width: 41,
      height: 52,
      badge: 5,
      onTap: () => navigateToNotifications(),
    ),
    BottomNavItem(
      icon: 'assets/figma_exports/profile.png',
      width: 53,
      height: 61,
      onTap: () => navigateToProfile(),
    ),
  ],
  centerItem: CenterNavItem(
    icon: 'assets/figma_exports/home.png',
    backgroundColor: Color(0xFF004917), // Dark green
    onTap: () => navigateToHome(),
  ),
)
```

### Example 2: Social Media App

```dart
CustomBottomNavigation(
  backgroundColor: Color(0xFF1A1A1A), // Dark theme
  items: [
    BottomNavItem(
      icon: 'assets/icons/feed.png',
      onTap: () {},
    ),
    BottomNavItem(
      icon: 'assets/icons/search.png',
      onTap: () {},
    ),
    BottomNavItem(
      icon: 'assets/icons/messages.png',
      badge: 24,
      badgeColor: Color(0xFFE91E63),
      onTap: () {},
    ),
    BottomNavItem(
      icon: 'assets/icons/profile.png',
      onTap: () {},
    ),
  ],
  centerItem: CenterNavItem(
    icon: 'assets/icons/create.png',
    backgroundColor: Color(0xFFE91E63), // Pink
    onTap: () => showCreateDialog(),
  ),
)
```

### Example 3: Full Page Integration

```dart
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2; // Start on home
  
  final List<Widget> _pages = [
    CartPage(),
    OrdersPage(),
    HomePage(),
    NotificationsPage(),
    ProfilePage(),
  ];

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
            icon: 'assets/icons/cart.png',
            onTap: () => setState(() => _currentIndex = 0),
          ),
          BottomNavItem(
            icon: 'assets/icons/orders.png',
            onTap: () => setState(() => _currentIndex = 1),
          ),
          BottomNavItem(
            icon: 'assets/icons/notifications.png',
            badge: 3,
            onTap: () => setState(() => _currentIndex = 3),
          ),
          BottomNavItem(
            icon: 'assets/icons/profile.png',
            onTap: () => setState(() => _currentIndex = 4),
          ),
        ],
        centerItem: CenterNavItem(
          icon: 'assets/icons/home.png',
          onTap: () => setState(() => _currentIndex = 2),
        ),
      ),
    );
  }
}
```

See `custom_bottom_navigation_example.dart` for 6 complete examples!

---

## 📚 API Reference

### CustomBottomNavigation

Main widget for the bottom navigation bar.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `items` | `List<BottomNavItem>` | **required** | List of 4 navigation items |
| `centerItem` | `CenterNavItem` | **required** | Elevated center button configuration |
| `backgroundColor` | `Color` | `Colors.white` | Background color of the bar |
| `height` | `double` | `95.0` | Height of the navigation bar |
| `selectedIndex` | `int` | `2` | Currently selected index (0-4) |

### BottomNavItem

Configuration for standard navigation items.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `icon` | `String` | **required** | Asset path for the icon |
| `width` | `double` | `40` | Icon width |
| `height` | `double` | `40` | Icon height |
| `onTap` | `VoidCallback?` | `null` | Callback when tapped |
| `badge` | `int?` | `null` | Badge count (null or 0 = no badge) |
| `badgeColor` | `Color` | `Color(0xFFC80000)` | Badge background color |
| `color` | `Color?` | `null` | Default icon color |
| `selectedColor` | `Color` | `Color(0xFF004917)` | Icon color when selected |

### CenterNavItem

Configuration for the elevated center button.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `icon` | `String` | **required** | Asset path for the icon |
| `onTap` | `VoidCallback?` | `null` | Callback when tapped |
| `size` | `double` | `89` | Outer circle diameter |
| `innerSize` | `double` | `67` | Inner circle diameter |
| `iconSize` | `double` | `37` | Icon size |
| `backgroundColor` | `Color` | `Color(0xFF004917)` | Inner circle color |
| `outerColor` | `Color` | `Colors.white` | Outer circle color |

---

## 🎨 Design Specifications

Based on Figma design specifications:

### Dimensions
- **Bar Height**: 95px
- **Bar Width**: 100% (responsive)
- **Center Button**: 89x89px (outer), 67x67px (inner)
- **Center Icon**: 37x37px

### Spacing
- Items are evenly distributed using `MainAxisAlignment.spaceEvenly`
- Center button elevation: 8px above bar
- Badge offset: -2px from top-right

### Colors (Vietnamese Fish Sauce App)
- **Bar Background**: `#FFFFFF` (white)
- **Center Button**: `#004917` (dark green)
- **Badge**: `#C80000` (red)
- **Selected State**: `#004917` (dark green)

### Shadows
- **Center Button**: 
  - Color: `rgba(0, 0, 0, 0.25)`
  - Blur: 8px
  - Offset: (0, 4)
- **Bar**:
  - Color: `rgba(0, 0, 0, 0.08)`
  - Blur: 8px
  - Offset: (0, -2)

### Typography (Badge)
- **Font**: Poppins Bold
- **Size**: 10px (8px for "99+")
- **Color**: White
- **Alignment**: Center

---

## 💡 Tips & Best Practices

### 1. Icon Preparation
- Use PNG with transparent background
- Recommended size: 2-3x the display size for crisp rendering
- Keep file sizes under 50KB each

### 2. Badge Management
```dart
// Good: Update badge dynamically
setState(() {
  notificationCount = newCount;
});

// Good: Hide badge when zero
BottomNavItem(
  badge: count > 0 ? count : null,
)
```

### 3. Navigation State
```dart
// Use IndexedStack for better performance
IndexedStack(
  index: _currentIndex,
  children: _pages,
)

// vs PreferredSizeWidget PageView (less efficient)
```

### 4. Accessibility
```dart
// Add semantic labels
Semantics(
  label: 'Navigate to cart',
  button: true,
  child: BottomNavItem(...),
)
```

### 5. Testing
```dart
// Test badge display
testWidgets('shows badge correctly', (tester) async {
  await tester.pumpWidget(
    CustomBottomNavigation(
      items: [
        BottomNavItem(icon: 'test.png', badge: 5),
        // ...
      ],
    ),
  );
  expect(find.text('5'), findsOneWidget);
});
```

---

## 🐛 Troubleshooting

### Icons not showing
**Problem**: Icons appear as placeholders or errors  
**Solution**: Verify asset paths in `pubspec.yaml` and file existence

### Badge not displaying
**Problem**: Badge doesn't show even with value > 0  
**Solution**: Ensure `badge` parameter is not null and value > 0

### Center button not elevated
**Problem**: Center button appears flat  
**Solution**: Ensure parent has `clipBehavior: Clip.none` in Stack

### Layout overflow
**Problem**: Items overflow on small screens  
**Solution**: Reduce icon sizes or bar height

---

## 📞 Support & Contributing

For issues, feature requests, or contributions:
1. Check existing examples in `custom_bottom_navigation_example.dart`
2. Review this guide for common solutions
3. Refer to Figma design: https://www.figma.com/design/DTsoPQ2H2y71hG7ftpTQZk/

---

## 📄 License

This component is part of the Vietnamese Fish Sauce App project.  
Free to use and modify for your projects.

---

## 🎉 Credits

- **Design**: Figma Design System
- **Implementation**: Based on Vietnamese Fish Sauce App
- **Framework**: Flutter
- **Fonts**: Poppins (Google Fonts)

**Version**: 1.0.0  
**Last Updated**: October 1, 2025

