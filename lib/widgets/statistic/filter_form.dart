import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:e_food/l10n/app_localizations.dart';

class FilterForm extends StatefulWidget {
  final int selectedMonth;
  final int selectedYear;
  final List<int> months;
  final List<int> years;
  final ValueChanged<int> onMonthChanged;
  final ValueChanged<int> onYearChanged;
  final VoidCallback onSearch;

  const FilterForm({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.months,
    required this.years,
    required this.onMonthChanged,
    required this.onYearChanged,
    required this.onSearch,
  });

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Month dropdown
          Text(
            l10n.month,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: widget.selectedMonth,
                items:
                    widget.months.map((month) {
                      return DropdownMenuItem<int>(
                        value: month,
                        child: SizedBox(
                          width: 30,
                          child: Text(
                            month.toString(),
                            style: AppTextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) => widget.onMonthChanged(value!),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Year dropdown
          Text(
            l10n.year,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: widget.selectedYear,
                items:
                    widget.years.map((year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: SizedBox(
                          width: 50,
                          child: Text(
                            year.toString(),
                            style: AppTextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) => widget.onYearChanged(value!),
              ),
            ),
          ),
          const Spacer(),
          // Search button
          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: widget.onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(l10n.search, style: AppTextStyles.buttonMedium),
            ),
          ),
        ],
      ),
    );
  }
}
