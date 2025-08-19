import 'package:flutter/material.dart';

class AppMenu extends StatelessWidget implements PreferredSizeWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF3D4854),
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: Colors.red, size: 20),
            SizedBox(width: 4),
          ],
        ),
      ),
      title: Text(
        'ĐẶT CƠM',
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
