import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Assets
  static const String assetsBase = 'assets/figma_exports';
  static const String pdpPattern =
      '$assetsBase/product_detail_pattern_large.svg';

  // Brand primary greens
  static const int _green00541A = 0xFF00541A; // Figma star/brand green
  static const int _green00C853 =
      0xFF00C853; // Vibrant bright green (price/selected)
  static const int _green024023 =
      0xFF024023; // Darker green variant from Figma var

  // Neutrals and text
  static const int textTitle = 0xFF1A0000; // Deep rich brown (titles)
  static const int textBody = 0xFF37474F; // Blue-gray body text
  static const int textMuted = 0xFF2D2D2D; // Subtitle

  // Surfaces
  static const int surfaceCream = 0xFFFFFDE7; // Warm cream background

  // Accent
  static const int accentOrange = 0xFFE65100; // Total price background
  static const int ctaBrown = 0xFF2E0000; // CTA button

  // Order Tracking Colors
  static const int orderTrackingActive = 0xFFFF6B00; // Orange for active status
  static const int orderTrackingInactive =
      0xFF8A8A8A; // Gray for inactive status
  static const int orderTrackingBorder = 0xFF00541A; // Green border color

  // Profile/Auth Colors
  static const int profilePrimaryRed =
      0xFF900407; // Deep red for buttons/accents
  static const int profileBrandRed =
      0xFFC80000; // Brand red for "HEALTHY CHOICE"
  static const int profileUserNameRed = 0xFFC62D1B; // Red for user name
  static const int profileTitleRed = 0xFF8E0306; // Red for page title
  static const int profileTextGray = 0xFF8A8A8A; // Gray for labels/muted text
  static const int profileBorderGray = 0xFFD9D9D9; // Border color
  static const int profileSearchBg = 0xFFF3F1F2; // Search bar background
  static const int profileSearchBorder = 0xFF3C3C3C; // Search bar border
  static const int profilePlaceholder = 0xFFBBBBBB; // Placeholder text

  // Semantic aliases
  static const int star = _green00541A;
  static const int price = _green00C853;
  static const int selected = _green00C853;
  static const int starAlt = _green024023;
  // Color-typed aliases (safe for direct use in widgets)
  static const Color cTextTitle = Color(textTitle);
  static const Color cTextBody = Color(textBody);
  static const Color cTextMuted = Color(textMuted);
  static const Color cSurfaceCream = Color(surfaceCream);
  static const Color cAccentOrange = Color(accentOrange);
  static const Color cCtaBrown = Color(ctaBrown);
  static const Color cStar = Color(star);
  static const Color cPrice = Color(price);
  static const Color cSelected = Color(selected);
  static const Color cStarAlt = Color(starAlt);
  static const Color cOrderTrackingActive = Color(orderTrackingActive);
  static const Color cOrderTrackingInactive = Color(orderTrackingInactive);
  static const Color cOrderTrackingBorder = Color(orderTrackingBorder);

  // Profile/Auth Color-typed aliases
  static const Color cProfilePrimaryRed = Color(profilePrimaryRed);
  static const Color cProfileBrandRed = Color(profileBrandRed);
  static const Color cProfileUserNameRed = Color(profileUserNameRed);
  static const Color cProfileTitleRed = Color(profileTitleRed);
  static const Color cProfileTextGray = Color(profileTextGray);
  static const Color cProfileBorderGray = Color(profileBorderGray);
  static const Color cProfileSearchBg = Color(profileSearchBg);
  static const Color cProfileSearchBorder = Color(profileSearchBorder);
  static const Color cProfilePlaceholder = Color(profilePlaceholder);
}
