import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const AppHeader({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16, top: 16),
      color: AppColors.white,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 8),
          Text(title, style: AppTextStyles.heading3),
        ],
      ),
    );
  }
}
