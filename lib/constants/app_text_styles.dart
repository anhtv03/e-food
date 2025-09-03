import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.black87,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black87,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.black87,
  );

  static const TextStyle heading4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.black87,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.black87,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: AppColors.black87,
  );

  static const TextStyle bodyXSmall = TextStyle(
    fontSize: 12,
    color: AppColors.black,
  );

  // Special text styles
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.grey700,
  );

  static const TextStyle note = TextStyle(
    fontSize: 12,
    color: AppColors.black,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle error = TextStyle(
    fontSize: 12,
    height: 1,
    color: AppColors.errorRed,
  );

  static const TextStyle hint = TextStyle(color: AppColors.grey400);

  // Button text styles
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle buttonSmall = TextStyle(fontSize: 12);

  // Table text styles
  static const TextStyle tableHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle tableCell = TextStyle(
    fontSize: 14,
    color: AppColors.black87,
  );

  // Drawer text styles
  static const TextStyle drawerTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle drawerItem = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.black87,
  );

  static const TextStyle drawerItemSelected = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  // Auth text styles
  static const TextStyle authTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle authSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.grey600,
  );

  static const TextStyle linkText = TextStyle(
    color: AppColors.teal,
    fontSize: 14,
  );

  static const TextStyle backButton = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
