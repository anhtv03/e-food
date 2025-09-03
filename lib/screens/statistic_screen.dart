import 'package:e_food/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_event.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_state.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/models/meal_statistic.dart';
import 'package:e_food/widgets/common/custom_app_drawer.dart';
import 'package:e_food/widgets/common/custom_app_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:e_food/l10n/app_localizations.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(
    10,
    (index) => DateTime.now().year - 5 + index,
  );

  @override
  void initState() {
    super.initState();
    context.read<StatisticBloc>().add(
      LoadStatisticEvent(month: selectedMonth, year: selectedYear),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppMenu(),
      endDrawer: AppDrawer(page: "statistic"),
      body: SingleChildScrollView(
        child: BlocConsumer<StatisticBloc, StatisticState>(
          listener: (context, state) {
            if (state is StatisticError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: AppColors.white,
                  child: Row(
                    children: [
                      Icon(Icons.bar_chart, color: AppColors.blue, size: 24),
                      SizedBox(width: 8),
                      Text(l10n.mealStatistics, style: AppTextStyles.heading3),
                    ],
                  ),
                ),

                Divider(
                  height: 10,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: AppColors.darkGreen,
                ),
                SizedBox(height: 16),

                // Filter section
                _buildFilterField(l10n),
                SizedBox(height: 16),

                // Statistics table
                _buildStatisticTable(state, l10n),
                SizedBox(height: 16),

                // Total amount section
                _buildTotalAmountField(state, l10n),
                SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }

  //========================handle UI==============================
  Widget _buildFilterField(AppLocalizations l10n) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          // Month dropdown
          Text(
            l10n.month,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          Container(
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedMonth,
                items:
                    months.map((month) {
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
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value!;
                  });
                },
              ),
            ),
          ),

          SizedBox(width: 16),

          // Year dropdown
          Text(
            l10n.year,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          Container(
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedYear,
                items:
                    years.map((year) {
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
                onChanged: (value) {
                  setState(() {
                    selectedYear = value!;
                  });
                },
              ),
            ),
          ),

          Spacer(),

          // Search button
          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: () {
                context.read<StatisticBloc>().add(
                  LoadStatisticEvent(month: selectedMonth, year: selectedYear),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 12),
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

  Widget _buildStatisticTable(state, AppLocalizations l10n) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table header
          _buildTableHeader(l10n),

          // Table content
          if (state is StatisticLoading)
            Container(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (state is StatisticLoaded)
            state.mealStatistics.isEmpty
                ? _buildEmptyState(l10n)
                : Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.mealStatistics.length,
                      itemBuilder: (context, index) {
                        final meal = state.mealStatistics[index];
                        return _buildTableRow(
                          meal,
                          index + 1,
                          state.mealStatistics.length,
                          l10n,
                        );
                      },
                    ),
                  ],
                )
          else if (state is StatisticError)
            Container(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.grey400,
                    ),
                    SizedBox(height: 16),
                    Text(
                      state.message,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blue600,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.grey400, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // STT
          SizedBox(
            width: 30,
            child: Text(
              l10n.no,
              style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          // Tên món
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                l10n.dishName,
                style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              ),
            ),
          ),

          // Giá (VNĐ)
          Expanded(
            flex: 2,
            child: Text(
              l10n.amount,
              style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          // Ngày cung cấp
          Expanded(
            flex: 2,
            child: Text(
              l10n.supplyDate,
              style: AppTextStyles.tableHeader.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    MealStatistic meal,
    int index,
    int length,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? AppColors.grey50 : AppColors.white,
        border:
            index == length
                ? null
                : Border(
                  bottom: BorderSide(color: AppColors.grey400, width: 1),
                ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            // STT
            SizedBox(
              width: 30,
              child: Text(
                index.toString(),
                style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),

            // Tên món
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  meal.mealName,
                  style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                ),
              ),
            ),

            // Giá (VNĐ)
            Expanded(
              flex: 2,
              child: Text(
                '${NumberFormat('#,###').format(meal.price)} VND',
                style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),

            // Ngày cung cấp
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('d/M/yyyy').format(meal.serviceDate),
                style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 64, color: AppColors.grey400),
            SizedBox(height: 16),
            Text(
              l10n.noData,
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.grey600),
            ),
            SizedBox(height: 8),
            Text(
              l10n.chooseOtherYear,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountField(state, AppLocalizations l10n) {
    final amount =
        (state is StatisticLoaded && state.mealStatistics.isNotEmpty)
            ? NumberFormat('#,###').format(state.totalAmount)
            : '0';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
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
