import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:e_food/l10n/app_localizations.dart';

class MealActionButtons extends StatelessWidget {
  final MealState buttonState;
  final VoidCallback? onOrder;
  final VoidCallback? onCancel;

  const MealActionButtons({
    super.key,
    required this.buttonState,
    this.onOrder,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(child: _buildCancelButton(l10n)),
        const SizedBox(width: 8),
        Expanded(child: _buildOrderButton(l10n)),
      ],
    );
  }

  Widget _buildCancelButton(AppLocalizations l10n) {
    bool isEnabled = buttonState == MealState.cancel;
    return SizedBox(
      height: 27,
      child: ElevatedButton(
        onPressed: isEnabled ? onCancel : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.red : AppColors.grey,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: isEnabled ? 2 : 0,
        ),
        child: Text(l10n.cancel, style: AppTextStyles.buttonSmall),
      ),
    );
  }

  Widget _buildOrderButton(AppLocalizations l10n) {
    switch (buttonState) {
      case MealState.order:
        return SizedBox(
          height: 27,
          child: ElevatedButton(
            onPressed: onOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightBlue,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(l10n.order, style: AppTextStyles.buttonSmall),
          ),
        );
      case MealState.cancel:
      case MealState.ordered:
        return Container(
          height: 27,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              l10n.ordered,
              style: AppTextStyles.buttonSmall.copyWith(color: AppColors.white),
            ),
          ),
        );
      case MealState.expired:
        return Container(
          height: 27,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              l10n.expired,
              style: AppTextStyles.buttonSmall.copyWith(color: AppColors.white),
            ),
          ),
        );
      case MealState.disabled:
        return Container(
          height: 27,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              l10n.order,
              style: AppTextStyles.buttonSmall.copyWith(color: AppColors.white),
            ),
          ),
        );
    }
  }
}
