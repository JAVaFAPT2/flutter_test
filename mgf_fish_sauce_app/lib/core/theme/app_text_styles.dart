import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Base Font Families - Vietnamese Support (using system fonts)
  static const String? primaryFontFamily = null; // System default
  static const String? secondaryFontFamily = null; // System default

  // Display Text Styles - Large headers
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryColor,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor,
    letterSpacing: -0.25,
    height: 1.3,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0,
    height: 1.3,
  );

  // Headline Text Styles - Section headers
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.15,
    height: 1.4,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Title Text Styles - Component titles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Body Text Styles - Main content
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.4,
    height: 1.3,
  );

  // Label Text Styles - Buttons and form labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.5,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Vietnamese E-commerce Specific Styles

  // Product Name Style
  static const TextStyle productName = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Product Description Style
  static const TextStyle productDescription = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.25,
    height: 1.5,
  );

  // Price Style
  static const TextStyle price = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
    letterSpacing: 0.15,
    height: 1.3,
  );

  // Original Price (Strikethrough) Style
  static const TextStyle originalPrice = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabledColor,
    letterSpacing: 0.25,
    height: 1.3,
    decoration: TextDecoration.lineThrough,
  );

  // Discount Percentage Style
  static const TextStyle discount = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.errorColor,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Cart Item Count Style
  static const TextStyle cartBadge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimaryColor,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Vietnamese Brand Names
  static const TextStyle brandName = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
    letterSpacing: 0.15,
    height: 1.3,
  );

  // Vietnamese Category Names
  static const TextStyle categoryName = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Error Message Style
  static const TextStyle errorMessage = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.errorColor,
    letterSpacing: 0.4,
    height: 1.3,
  );

  // Success Message Style
  static const TextStyle successMessage = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.successColor,
    letterSpacing: 0.4,
    height: 1.3,
  );

  // Warning Message Style
  static const TextStyle warningMessage = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.warningColor,
    letterSpacing: 0.4,
    height: 1.3,
  );

  // Vietnamese Phone Number Style
  static const TextStyle phoneNumber = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryColor,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Vietnamese Address Style
  static const TextStyle address = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.25,
    height: 1.5,
  );

  // Order Status Style
  static const TextStyle orderStatus = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Button Text Style
  static const TextStyle buttonText = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Form Label Style
  static const TextStyle formLabel = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.5,
    height: 1.3,
  );

  // Complete TextTheme for Material 3
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  // Primary TextTheme (for AppBar, etc.)
  static const TextTheme primaryTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: -0.5,
      height: 1.2,
    ),
    displayMedium: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: -0.25,
      height: 1.3,
    ),
    displaySmall: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0,
      height: 1.3,
    ),
    headlineLarge: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.15,
      height: 1.4,
    ),
    headlineSmall: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.15,
      height: 1.4,
    ),
    titleLarge: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.15,
      height: 1.5,
    ),
    titleMedium: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.1,
      height: 1.4,
    ),
    titleSmall: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.1,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.25,
      height: 1.4,
    ),
    bodySmall: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.4,
      height: 1.3,
    ),
    labelLarge: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.1,
      height: 1.4,
    ),
    labelMedium: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.5,
      height: 1.3,
    ),
    labelSmall: TextStyle(
      fontFamily: primaryFontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.textOnPrimaryColor,
      letterSpacing: 0.5,
      height: 1.2,
    ),
  );
}
