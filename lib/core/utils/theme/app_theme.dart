import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const textTheme = TextTheme(
      // Display styles (largest text)
      displayLarge: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w300, // Light
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 45,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 28,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700, // Bold
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 14,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 12,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500, // Medium
        fontSize: 11,
      ),
    );
    const appBarTheme = AppBarTheme(
      backgroundColor: AppColors.pureWhite,
      foregroundColor: AppColors.textBlack,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.textBlack,
      ),
    );
    var elevatedButtonThemeData = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles.urbanist16600LightBackground,
        backgroundColor: AppColors.buttonBlack,
        foregroundColor: AppColors.lightBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
    var inputDecorationTheme = InputDecorationTheme(
      // Field text style
      labelStyle: AppTextStyles.urbanist14600TextGrey,
      hintStyle: AppTextStyles.urbanist15500MediumGrey,
      errorStyle: AppTextStyles.urbanist12600PureBlack.copyWith(
        color: AppColors.accentRed,
      ),
      // Field background
      filled: true,
      fillColor: AppColors.fieldGreyFill,

      // Content padding
      contentPadding: const EdgeInsets.all(18),
      // Default border (enabled state)
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.cardGrey,
          width: 1,
        ),
      ),
      // Focused border (when user taps/clicks)
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.fieldGreyBorder,
          width: 2,
        ),
      ),

      // Error border (validation fails)
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.accentRed,
          width: 1,
        ),
      ),

      // Focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.accentRed,
          width: 2,
        ),
      ),

      // Disabled border
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.textGrey60,
          width: 1,
        ),
      ),
    );
    return ThemeData(
      fontFamily: 'Urbanist', // This makes Urbanist your default font
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.pureWhite,
      appBarTheme: appBarTheme,
      elevatedButtonTheme: elevatedButtonThemeData,
      inputDecorationTheme: inputDecorationTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.buttonBlack, // Or any color you prefer
      ),

      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent, // Remove the oval
        elevation: 10,
        labelBehavior:
            NavigationDestinationLabelBehavior.alwaysHide, // Optional
      ),
    );
  }
}
