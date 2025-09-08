import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UserGreeting extends StatelessWidget {
  final String userName;

  const UserGreeting({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: AppColors.white,
      child: Text(l10n.welcomeUser(userName), style: AppTextStyles.subtitle),
    );
  }
}
