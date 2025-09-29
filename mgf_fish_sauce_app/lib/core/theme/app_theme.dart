import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: AppColors.textOnPrimaryColor,
        primaryContainer: AppColors.primaryLightColor,
        onPrimaryContainer: AppColors.textPrimaryColor,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.textOnSecondaryColor,
        secondaryContainer: AppColors.secondaryLightColor,
        onSecondaryContainer: AppColors.textPrimaryColor,
        tertiary: AppColors.accentColor,
        onTertiary: AppColors.textPrimaryColor,
        tertiaryContainer: AppColors.accentLightColor,
        onTertiaryContainer: AppColors.textPrimaryColor,
        error: AppColors.errorColor,
        onError: AppColors.textOnPrimaryColor,
        errorContainer: AppColors.errorLightColor,
        onErrorContainer: AppColors.textPrimaryColor,
        surface: AppColors.surfaceColor,
        onSurface: AppColors.textPrimaryColor,
        surfaceContainerHighest: AppColors.cardColor,
        onSurfaceVariant: AppColors.textSecondaryColor,
        outline: AppColors.borderColor,
        outlineVariant: AppColors.borderLightColor,
        shadow: AppColors.shadowColor,
        scrim: AppColors.overlayColor,
        inverseSurface: AppColors.textPrimaryColor,
        onInverseSurface: AppColors.textOnPrimaryColor,
        inversePrimary: AppColors.primaryLightColor,
        surfaceTint: AppColors.primaryColor,
      ),

      // Typography - Vietnamese Font Support
      textTheme: AppTextStyles.textTheme,
      primaryTextTheme: AppTextStyles.primaryTextTheme,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnPrimaryColor,
        elevation: 2,
        shadowColor: AppColors.shadowColor,
        surfaceTintColor: AppColors.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.textOnPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
        toolbarTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textOnPrimaryColor,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textOnPrimaryColor,
          size: 24,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppColors.textOnPrimaryColor,
          size: 24,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondaryColor,
        selectedIconTheme: IconThemeData(
          color: AppColors.primaryColor,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.textSecondaryColor,
          size: 24,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.textOnPrimaryColor,
          disabledBackgroundColor: AppColors.textDisabledColor,
          disabledForegroundColor: AppColors.textSecondaryColor,
          elevation: 2,
          shadowColor: AppColors.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          disabledForegroundColor: AppColors.textDisabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          disabledForegroundColor: AppColors.textDisabledColor,
          side: const BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderLightColor,
            width: 1,
          ),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondaryColor,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textDisabledColor,
        ),
        errorStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.errorColor,
        ),
        helperStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondaryColor,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.cardColor,
        shadowColor: AppColors.shadowColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceColor,
        disabledColor: AppColors.textDisabledColor,
        selectedColor: AppColors.primaryLightColor,
        secondarySelectedColor: AppColors.secondaryLightColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        labelStyle: AppTextStyles.bodySmall,
        secondaryLabelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textOnSecondaryColor,
        ),
        brightness: Brightness.light,
        elevation: 1,
        pressElevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryColor,
        size: 24,
      ),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppColors.textOnPrimaryColor,
        size: 24,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.textPrimaryColor,
        elevation: 6,
        shape: CircleBorder(),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textDisabledColor;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLightColor;
          }
          return AppColors.borderColor;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.borderColor;
        }),
      ),

      // Slider Theme
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primaryColor,
        inactiveTrackColor: AppColors.borderColor,
        thumbColor: AppColors.primaryColor,
        overlayColor: AppColors.primaryLightColor,
        valueIndicatorColor: AppColors.primaryColor,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        linearTrackColor: AppColors.borderColor,
        circularTrackColor: AppColors.borderColor,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.textSecondaryColor,
        indicatorColor: AppColors.primaryColor,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.labelMedium,
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surfaceColor,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.textPrimaryColor,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondaryColor,
        ),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimaryColor,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textOnPrimaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
      ),

      // Vietnamese E-commerce Specific
      primarySwatch: MaterialColor(
        AppColors.primaryColor.value,
        <int, Color>{
          50: AppColors.primaryLightColor.withOpacity(0.1),
          100: AppColors.primaryLightColor.withOpacity(0.2),
          200: AppColors.primaryLightColor.withOpacity(0.3),
          300: AppColors.primaryLightColor.withOpacity(0.4),
          400: AppColors.primaryLightColor.withOpacity(0.5),
          500: AppColors.primaryColor,
          600: AppColors.primaryDarkColor.withOpacity(0.8),
          700: AppColors.primaryDarkColor.withOpacity(0.9),
          800: AppColors.primaryDarkColor,
          900: AppColors.primaryDarkColor,
        },
      ),
    );
  }

  static ThemeData get darkTheme {
    // Dark theme implementation for future use
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      // Dark theme customizations can be added here
    );
  }
}
