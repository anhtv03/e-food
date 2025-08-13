import 'package:e_food/pages/home_page.dart';
import 'package:e_food/pages/login_page.dart';
import 'package:e_food/pages/history_page.dart';
import 'package:e_food/pages/statistic_page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String page;
  const AppDrawer({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 24),
                SizedBox(width: 8),
                Text(
                  'ĐẶT CƠM',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: Colors.black54, size: 24),
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
                  iconColor: Colors.orange,
                  isSelected: page == "home" ? true : false,
                  title: 'Món ăn trong tuần',
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
                  iconColor: Colors.blue,
                  isSelected: page == "history" ? true : false,
                  title: 'Lịch sử đặt món',
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
                  iconColor: Colors.green,
                  isSelected: page == "statistic",
                  title: 'Thống kê suất ăn',
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
                  iconColor: Colors.red,
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
                    : Colors.transparent,
            borderRadius: BorderRadius.zero,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.black87 : Colors.black87,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Colors.grey[50],
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Đăng xuất'),
              ),
            ],
          ),
    );
  }
}
