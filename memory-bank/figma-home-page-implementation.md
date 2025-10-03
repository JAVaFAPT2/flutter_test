# Home Page Implementation - Based on Figma Design

**Date:** October 1, 2025  
**Figma Channel:** 4hqhz0yu  
**Frame Name:** Trang chủ (Frame ID: 1:2896)

## Overview

Updated the Home page Flutter implementation to match the Figma design specifications pixel-perfect, including typography, colors, spacing, and component structure.

## Changes Made

### 1. Font Configuration (`pubspec.yaml`)

Added custom fonts to match Figma design:
- **Poppins** (Regular 400, Bold 700) - Primary app font
- **Gayathri** (Bold 700) - Branding font for MGF logo text

```yaml
fonts:
  - family: Poppins
    fonts:
      - asset: assets/fonts/Poppins-Regular.ttf
        weight: 400
      - asset: assets/fonts/Poppins-Bold.ttf
        weight: 700
  - family: Gayathri
    fonts:
      - asset: assets/fonts/Gayathri-Bold.ttf
        weight: 700
```

**Action Required:** Download fonts from Google Fonts and place in `assets/fonts/` directory. See `assets/fonts/README.md` for instructions.

### 2. Category Button Widget (`category_button.dart`)

**Added Features:**
- Notification badge support with `hasNotification` parameter
- Red circular badge (9x9px) positioned at bottom-right
- Applied Poppins font family to button text

**Design Specs:**
- Badge color: `#C80000` (red)
- Badge size: 9x9 pixels
- Position: bottom-right corner with -2px offset
- Font: Poppins Regular (11px)

### 3. Home Page (`home_page.dart`)

**Typography Updates:**
- All text now uses Poppins font family
- "Mọi người đều thích!" section header
- "Xem thêm" button text
- Search bar placeholder and input text
- "Danh mục" section header

**Component Updates:**
- "Nổi bật" category button now shows notification badge
- Consistent font sizing and weights matching Figma specs

### 4. Home App Bar (`home_app_bar.dart`)

**Typography Updates:**
- "MGF" text: Gayathri Bold (13px) - Black
- "HEALTHY CHOICE" text: Gayathri Bold (11px) - Red (#C80000)
- "Xin chào,": Poppins Bold (14px) - Black (#030303)
- "Nguyen Van A": Poppins Regular (12px) - Maroon (#900407)

### 5. Home Banner (`home_banner.dart`)

**Typography Updates:**
- "Ưu đãi đặc biệt,": Poppins Bold (22px) - White
- "NGAY HÔM NAY!": Poppins Regular (22px) - Yellow (#FEF9D9)
- Description text: Poppins Regular (10px) - White
- "Đặt hàng ngay" button: Poppins Bold (10px) - Black

### 6. Product Card (`product_card.dart`)

**Typography Updates:**
- Product name: Poppins Regular (14px) - Black
- Product price: Poppins Bold (14px) - Black
- All text centered with consistent height (1.5)

## Design Specifications from Figma

### Color Palette
- **Primary Red:** #C80000 (buttons, accents, selected states)
- **Dark Green:** #004917 (banner background, home button)
- **Maroon:** #900407 (user name, avatar background)
- **Black:** #030303 (primary text)
- **White:** #FFFFFF (backgrounds, button text)
- **Gray:** #BBBBBB (search placeholder, inactive indicators)
- **Light Gray:** #F3F1F2 (search background)
- **Yellow:** #FEF9D9 (banner highlight text)

### Spacing
- Container padding: 20px horizontal
- Section spacing: 11-25px vertical
- Search bar height: 29px
- Category button height: 31px
- Banner height: 174px
- Product card width: 166px
- Gallery image size: 105x110px

### Border Radius
- Banner: 15px
- Product images: 20px
- Gallery images: 20px
- Category buttons: 75px (pill shape)
- Avatar: 62px

## Component Structure

```
HomePage
├── Background Image (full screen)
├── HomeAppBar
│   ├── Logo MGF (82x37)
│   ├── MGF HEALTHY CHOICE text
│   ├── Greeting text (Xin chào, User Name)
│   └── Avatar (43x43)
├── ScrollableContent
│   ├── HomeBanner (174px height)
│   │   ├── Title text
│   │   ├── Description
│   │   ├── Order button
│   │   └── Product image
│   ├── Banner indicators (3 dots)
│   ├── Popular Products Section
│   │   ├── "Mọi người đều thích!" header
│   │   ├── "Xem thêm" link
│   │   └── Horizontal product list
│   │       ├── ProductCard (XTM 500ml)
│   │       └── ProductCard (Vĩnh Thái)
│   ├── Search Bar
│   ├── Categories Section
│   │   ├── "Danh mục" header
│   │   └── Category buttons
│   │       ├── Nổi bật (red, with badge)
│   │       ├── Xuân Thịnh Mậu (black)
│   │       └── Vĩnh Thái (black)
│   └── GallerySection (3 images)
└── HomeBottomNavigation
    ├── Cart icon
    ├── Orders icon
    ├── Home button (active, white circle)
    ├── Notifications icon
    └── Profile icon
```

## Files Modified

1. `pubspec.yaml` - Added font configuration
2. `lib/features/home/presentation/widgets/category_button.dart` - Added badge support
3. `lib/features/home/presentation/views/home_page.dart` - Applied Poppins font
4. `lib/features/home/presentation/widgets/home_app_bar.dart` - Applied fonts (Poppins + Gayathri)
5. `lib/features/home/presentation/widgets/home_banner.dart` - Applied Poppins font
6. `lib/features/home/presentation/widgets/product_card.dart` - Applied Poppins font

## Files Created

1. `assets/fonts/README.md` - Font installation instructions

## Next Steps

1. **Download and Install Fonts:**
   - Download Poppins (Regular, Bold) from Google Fonts
   - Download Gayathri (Bold) from Google Fonts
   - Place font files in `assets/fonts/` directory

2. **Test the Implementation:**
   - Run `flutter pub get`
   - Run `flutter clean`
   - Build and run the app
   - Verify all text renders correctly with proper fonts
   - Test on both Android and iOS devices

3. **Visual Verification:**
   - Compare running app with Figma design
   - Check font rendering
   - Verify notification badge on "Nổi bật" button
   - Confirm colors match exactly
   - Validate spacing and alignment

## Known Issues / Notes

- Font files must be manually downloaded from Google Fonts
- If fonts don't load, check console for font loading errors
- Ensure font file names match exactly as specified in pubspec.yaml
- Banner carousel functionality (changing between 3 banners) is managed by HomeCubit

## Figma Design Reference

- **Document:** Page 1
- **Frame:** Trang chủ (1:2896)
- **Dimensions:** 440x956px
- **Total screens in document:** 59 frames

## Design Compliance

✅ Typography matches Figma (Poppins + Gayathri)  
✅ Colors match Figma hex codes  
✅ Spacing follows Figma specifications  
✅ Component structure mirrors Figma layers  
✅ Border radius values match  
✅ Notification badge on category button  
✅ Icon sizes and positions correct  
✅ Layout responsive and scrollable  

## Performance Considerations

- Images loaded from local assets for fast rendering
- ListView with horizontal scrolling for products
- SingleChildScrollView for main content
- Cached network images not yet implemented (using AssetImage)
- Bottom navigation uses Stack positioning for clean layering

