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

  // Semantic aliases
  static const int star = _green00541A;
  static const int price = _green00C853;
  static const int selected = _green00C853;
  static const int starAlt = _green024023;
}
