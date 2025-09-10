import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTable extends StatelessWidget {
  final Widget header;
  final List<Widget> rows;
  final bool isLoading;
  final Widget emptyState;

  const AppTable({
    super.key,
    required this.header,
    required this.rows,
    required this.isLoading,
    required this.emptyState,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withValues(alpha: 0.3),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              header,
              isLoading
                  ? const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CupertinoActivityIndicator()),
                  )
                  : rows.isEmpty
                  ? emptyState
                  : Column(children: rows),
            ],
          ),
        ),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  final String noLabel;
  final String dishNameLabel;
  final String dateLabel;
  final String? thirdColumnLabel;
  final Color headerColor;

  const TableHeader({
    super.key,
    required this.noLabel,
    required this.dishNameLabel,
    required this.dateLabel,
    this.thirdColumnLabel,
    required this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.grey400, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: thirdColumnLabel != null ? 40 : 30,
            child: Text(
              noLabel,
              style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                dishNameLabel,
                style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              dateLabel,
              style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          if (thirdColumnLabel != null)
            Expanded(
              flex: 2,
              child: Text(
                thirdColumnLabel!,
                style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String message;
  final String? subMessage;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.message,
    this.subMessage,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppColors.grey400),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.grey600),
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
