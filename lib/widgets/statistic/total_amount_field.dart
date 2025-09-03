import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:e_food/l10n/app_localizations.dart';

class TotalAmountField extends StatelessWidget {
  final String amount;

  const TotalAmountField({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.totalAmount(amount),
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
