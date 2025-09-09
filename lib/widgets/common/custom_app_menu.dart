import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../constants/app_assets.dart';

class AppMenu extends StatelessWidget implements PreferredSizeWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AppBar(
      backgroundColor: AppColors.backgroundMenu,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 16),
        child: Image.asset(AppAssets.foodIcon, width: 25, height: 25),
      ),
      title: Text(
        localizations.appTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Builder(
          builder:
              (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.menu, color: Colors.white),
              ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
