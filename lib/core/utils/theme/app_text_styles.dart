import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles for the app based on Figma design system
/// Naming convention: [fontFamily][fontSize][fontWeight][colorName]
class AppTextStyles {
  // Prevent instantiation
  AppTextStyles._();

  // ==================== URBANIST FONT STYLES ====================
  /// 30px Bold Dark Navy - Hero headings
  static const TextStyle urbanist30700DarkNavy = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.darkNavy,
  );

  /// 28px SemiBold Text Black - Main headings
  static const TextStyle urbanist28600TextBlack = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  /// 24px SemiBold Text Black - Section headings
  static const TextStyle urbanist24600TextBlack = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  /// 24px SemiBold Text Grey 75% - Overlay headings
  static const TextStyle urbanist24600TextGrey75 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey75,
  );

  /// 16px SemiBold Pure Black - Primary body text
  static const TextStyle urbanist16600PureBlack = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.pureBlack,
  );

  /// 16px SemiBold Light Background - Button text on dark backgrounds
  static const TextStyle urbanist16600LightBackground = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.lightBackground,
  );

  /// 16px SemiBold Pure White - Text on dark backgrounds
  static const TextStyle urbanist16600PureWhite = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.pureWhite,
  );

  /// 15px Medium Medium Grey - Secondary body text
  static const TextStyle urbanist15500MediumGrey = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGrey,
  );

  /// 14px SemiBold Pure Black - Small body text
  static const TextStyle urbanist14600PureBlack = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.pureBlack,
  );

  /// 14px SemiBold Text Grey 75% - Subtle small text
  static const TextStyle urbanist14600TextGrey75 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey75,
  );

  /// 14px SemiBold Text Grey - Muted small text
  static const TextStyle urbanist14600TextGrey = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey,
  );

  /// 14px SemiBold Text Black - Small text on light backgrounds
  static const TextStyle urbanist14600TextBlack = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  /// 14px SemiBold Text Grey 60% - Text on dark backgrounds
  static const TextStyle urbanist14600TextGrey60 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey60,
  );

  /// 14px SemiBold Dark Charcoal - Text on medium backgrounds
  static const TextStyle urbanist14600DarkCharcoal = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.darkCharcoal,
  );

  /// 12px SemiBold Pure Black - Caption text
  static const TextStyle urbanist12600PureBlack = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.pureBlack,
  );
  static const TextStyle urbanist12600PureBlack50 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.pureBlack50,
  );

  /// 12px SemiBold Text Grey - Muted caption text
  static const TextStyle urbanist12600TextGrey = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey,
  );

  /// 12px SemiBold Text Grey 75% - Overlay caption text
  static const TextStyle urbanist12600TextGrey75 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey75,
  );

  /// 12px SemiBold Dark Charcoal - Caption on medium backgrounds
  static const TextStyle urbanist12600DarkCharcoal = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.darkCharcoal,
  );

  /// 12px Bold Text Grey 80% - Label text
  static const TextStyle urbanist12700TextGrey80 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.textGrey80,
  );

  // ==================== LORA FONT STYLES ====================

  /// 20px SemiBold Text Grey 80% - Serif headings
  static const TextStyle lora20600TextGrey80 = TextStyle(
    fontFamily: 'Lora',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey80,
  );

  // ==================== SYSTEM FONT STYLES ====================

  /// 12px Medium Charcoal Grey - System UI text
  static const TextStyle system12500CharcoalGrey = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.charcoalGrey,
  );

  // ==================== HELPER METHODS ====================

  /// Create a custom text style based on existing ones
  /// Usage: AppTextStyles.customStyle(AppTextStyles.urbanist16600PureBlack, color: AppColors.accentRed)
  static TextStyle customStyle(
    TextStyle baseStyle, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return baseStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }
}
