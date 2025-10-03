# Home Feature - Clean Architecture

## Overview
This module implements the home page following Clean Architecture principles and Figma design specifications.

## Architecture Structure

```
lib/features/home/
├── presentation/
│   ├── views/
│   │   └── home_page.dart          ← Main Figma-based home page
│   ├── widgets/
│   │   ├── bottom_navigation.dart  ← Custom bottom nav (uses shared widget)
│   │   ├── category_button.dart    ← Category filter buttons with badge
│   │   ├── gallery_section.dart    ← Image gallery
│   │   ├── home_app_bar.dart       ← App bar with logo & greeting
│   │   ├── home_banner.dart        ← Promotional banner with carousel
│   │   └── product_card.dart       ← Product display cards
│   └── cubit/
│       └── home_cubit.dart         ← Home page state management
```

## Design Source
Based on Figma design: https://www.figma.com/design/DTsoPQ2H2y71hG7ftpTQZk/Untitled?node-id=1-2896

## Features
- ✅ Figma-accurate UI implementation
- ✅ Custom bottom navigation with elevated center button
- ✅ Banner carousel with indicators
- ✅ Product listing with horizontal scroll
- ✅ Category filtering with notification badges
- ✅ Search functionality
- ✅ Image gallery section
- ✅ Responsive layout

## Dependencies
- **Shared Widgets:** `lib/shared/widgets/custom_bottom_navigation.dart`
- **Assets:** `lib/core/constants/figma_assets.dart`
- **State Management:** BLoC/Cubit pattern

## Usage

### In Router (app_router.dart)
```dart
import '../../../features/home/presentation/views/home_page.dart';

GoRoute(
  path: '/home',
  name: 'home',
  builder: (context, state) => const HomePage(),
)
```

### Direct Navigation
```dart
import 'package:vietnamese_fish_sauce_app/features/home/presentation/views/home_page.dart';

Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const HomePage()),
);
```

## Key Components

### 1. HomePage (home_page.dart)
Main page widget with:
- Background image
- Scrollable content
- Custom bottom navigation
- All sub-widgets integrated

### 2. HomeAppBar (home_app_bar.dart)
- MGF logo
- "MGF HEALTHY CHOICE" branding
- User greeting ("Xin chào, [Name]")
- User avatar

### 3. HomeBanner (home_banner.dart)
- Promotional content
- "Đặt hàng ngay" CTA button
- Product image
- Carousel indicators (3 dots)

### 4. ProductCard (product_card.dart)
- Product image (rounded corners)
- Product name
- Price (bold)
- Like icon (optional)

### 5. CategoryButton (category_button.dart)
- Category label
- Selected/unselected states
- Notification badge support
- Red dot indicator for "Nổi bật"

### 6. GallerySection (gallery_section.dart)
- 3 image grid
- Rounded corners
- Horizontal layout

### 7. HomeBottomNavigation (bottom_navigation.dart)
Uses the custom bottom navigation component:
- Cart icon (left)
- Orders icon
- Home button (elevated center)
- Notifications icon (with badge support)
- Profile icon (right)

## Design Specifications

### Colors
- **Primary Red:** #C80000 (buttons, selected states)
- **Dark Green:** #004917 (banner, home button)
- **Maroon:** #900407 (user name)
- **Black:** #030303 (text)
- **White:** #FFFFFF (backgrounds)
- **Gray:** #BBBBBB (placeholders)

### Typography
- **Font Family:** Poppins (Regular 400, Bold 700)
- **Brand Font:** Gayathri (Bold 700) for "MGF HEALTHY CHOICE"
- **Sizes:** 10-22px depending on element

### Spacing
- **Container Padding:** 20px horizontal
- **Vertical Gaps:** 11-25px between sections
- **Bottom Nav Height:** 95px
- **Banner Height:** 174px

### Border Radius
- **Banner:** 15px
- **Product Images:** 20px
- **Gallery Images:** 20px
- **Category Buttons:** 75px (pill shape)
- **Search Bar:** 57px

## State Management

### HomeCubit
Manages:
- Current banner index (carousel)
- Selected category
- Product loading states
- Notification counts

### Usage
```dart
BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Text('Banner: ${state.currentBannerIndex}');
  },
)
```

## Assets Required

### Images
- Background: `FigmaAssets.background`
- Logo: `FigmaAssets.logoMgf`
- Products: `FigmaAssets.productXtm500ml`, `FigmaAssets.productVinhThai`
- Gallery: `FigmaAssets.galleryImage1-3`
- Icons: Cart, Orders, Notifications, Profile, Home
- Banner Product: `FigmaAssets.bannerProduct`

### Icons
- Search: `FigmaAssets.searchIcon`
- Arrow: `FigmaAssets.arrowRight`
- Like: `FigmaAssets.likeIcon`

## Navigation

### From Home
- Cart → `/cart`
- Orders → `/orders`
- Notifications → `/notifications`
- Profile → `/profile`
- Product Detail → `/product-detail` (with product data)
- Products List → `/products`

### To Home
- From Login → After successful login
- From Register → After successful registration
- From any page → Tap home button in bottom nav

## Testing

### Widget Tests
Test all widgets individually:
```dart
testWidgets('HomePage displays correctly', (tester) async {
  await tester.pumpWidget(MaterialApp(home: HomePage()));
  expect(find.byType(HomeAppBar), findsOneWidget);
  expect(find.byType(HomeBanner), findsOneWidget);
  expect(find.byType(HomeBottomNavigation), findsOneWidget);
});
```

### Integration Tests
Test navigation and interactions:
- Banner carousel swiping
- Category button selection
- Product card tapping
- Search functionality
- Bottom navigation

## Performance Considerations

- **Images:** Use `CachedNetworkImage` for remote images
- **Lists:** Horizontal `ListView` for products (lazy loading)
- **Scrolling:** `SingleChildScrollView` for main content
- **State:** BLoC pattern for efficient rebuilds
- **Assets:** Pre-load critical images

## Future Enhancements

- [ ] Pull-to-refresh functionality
- [ ] Product favoriting
- [ ] Search autocomplete
- [ ] Category filtering logic
- [ ] Banner auto-scroll
- [ ] Skeleton loading states
- [ ] Error handling UI
- [ ] Empty states

## Notes

- **Fonts:** Poppins and Gayathri fonts commented out in pubspec.yaml
  - Download from Google Fonts to enable
  - See `assets/fonts/README.md` for instructions
- **Bottom Navigation:** Reuses `lib/shared/widgets/custom_bottom_navigation.dart`
- **Clean Architecture:** Follows feature-based structure
- **Figma Accurate:** Pixel-perfect implementation

## Changelog

### Version 1.0.0 (October 1, 2025)
- ✅ Initial implementation based on Figma Frame 1:2896
- ✅ Custom bottom navigation integration
- ✅ All widgets created
- ✅ Clean Architecture structure
- ✅ State management with Cubit
- ✅ Routing configuration
- ✅ Asset management

## Related Documentation
- `lib/shared/widgets/CUSTOM_BOTTOM_NAV_GUIDE.md` - Bottom nav component guide
- `memory-bank/figma-home-page-implementation.md` - Implementation details
- `CUSTOM_BOTTOM_NAV_README.md` - Quick start for bottom nav

## Contact
For questions or improvements, refer to the main project documentation.

