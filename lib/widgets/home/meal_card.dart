import 'package:e_food/constants/api_constants.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:e_food/l10n/app_localizations.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final Widget actionButtons;

  const MealCard({super.key, required this.meal, required this.actionButtons});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Meal image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 150,
                height: 94,
                color: AppColors.grey200,
                child:
                    meal.imageUrl != null
                        ? Image.network(
                          RouteConstants.getImageUrl(meal.imageUrl!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.grey300,
                              child: const Icon(
                                Icons.restaurant,
                                color: AppColors.grey600,
                                size: 40,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.grey600,
                                ),
                              ),
                            );
                          },
                        )
                        : Container(
                          color: AppColors.grey300,
                          child: const Icon(
                            Icons.restaurant,
                            color: AppColors.grey600,
                            size: 40,
                          ),
                        ),
              ),
            ),
            const SizedBox(width: 12),
            // Meal info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.formatAmount(NumberFormat('#,###').format(meal.price)),
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.formatDate(
                      DateFormat('dd/MM/yyyy').format(meal.serviceDate),
                    ),
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  actionButtons,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
