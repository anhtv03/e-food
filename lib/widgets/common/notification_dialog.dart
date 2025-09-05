import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/l10n/app_localizations.dart';
import 'package:e_food/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showSuccessDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context);

      return AlertDialog(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              l10n.yes,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

void showCancelConfirmDialog(
  BuildContext context,
  Meal meal,
  AppLocalizations l10n,
) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(l10n.confirmCancel, style: AppTextStyles.heading4),
          content: Text(
            l10n.confirmMsgCancel(meal.name),
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.unconfirm, style: AppTextStyles.linkText),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<HomeBloc>().add(
                  CancelMealEvent(meal: meal, localizations: l10n),
                );
                showSuccessDialog(context, l10n.updateSuccess);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
              child: Text(
                l10n.confirm,
                style: AppTextStyles.buttonMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
  );
}
