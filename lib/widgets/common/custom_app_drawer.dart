import 'package:e_food/l10n/app_localizations.dart';
import 'package:e_food/screens/home_screen.dart';
import 'package:e_food/screens/login_screen.dart';
import 'package:e_food/screens/history_screen.dart';
import 'package:e_food/screens/statistic_screen.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String page;

  const AppDrawer({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Drawer(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(color: AppColors.grey200, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.red, size: 24),
                SizedBox(width: 8),
                Text(
                  localizations.appTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: AppColors.black54, size: 24),
                ),
              ],
            ),
          ),

          // Menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context: context,
                  icon: Icons.restaurant_menu,
                  iconColor: AppColors.orange,
                  isSelected: page == "home" ? true : false,
                  title: localizations.weeklyMeals,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.history,
                  iconColor: AppColors.blue,
                  isSelected: page == "history" ? true : false,
                  title: localizations.orderHistory,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.analytics_outlined,
                  iconColor: AppColors.green,
                  isSelected: page == "statistic",
                  title: localizations.mealStatistics,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.logout,
                  iconColor: AppColors.red,
                  title: 'Đăng xuất',
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color:
                isSelected
                    ? iconColor.withValues(alpha: 0.1)
                    : AppColors.transparent,
            borderRadius: BorderRadius.zero,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: AppColors.black87,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppColors.grey50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Xác nhận đăng xuất'),
            content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                child: Text('Đăng xuất'),
              ),
            ],
          ),
    );
  }
}
