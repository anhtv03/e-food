import 'package:e_food/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_event.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_state.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/models/meal_statistic.dart';
import 'package:e_food/widgets/common/custom_app_drawer.dart';
import 'package:e_food/widgets/common/custom_app_header.dart';
import 'package:e_food/widgets/common/custom_app_menu.dart';
import 'package:e_food/widgets/common/custom_app_table.dart';
import 'package:e_food/widgets/statistic/filter_form.dart';
import 'package:e_food/widgets/statistic/total_amount_field.dart';
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
                AppHeader(
                  title: l10n.mealStatistics,
                  icon: Icons.bar_chart,
                  iconColor: AppColors.blue,
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: AppColors.darkGreen,
                ),
                const SizedBox(height: 16),
                FilterForm(
                  selectedMonth: selectedMonth,
                  selectedYear: selectedYear,
                  months: months,
                  years: years,
                  onMonthChanged:
                      (value) => setState(() => selectedMonth = value),
                  onYearChanged:
                      (value) => setState(() => selectedYear = value),
                  onSearch:
                      () => context.read<StatisticBloc>().add(
                        LoadStatisticEvent(
                          month: selectedMonth,
                          year: selectedYear,
                        ),
                      ),
                ),
                const SizedBox(height: 16),
                AppTable(
                  header: TableHeader(
                    noLabel: l10n.no,
                    dishNameLabel: l10n.dishName,
                    dateLabel: l10n.supplyDate,
                    thirdColumnLabel: l10n.amount,
                    headerColor: AppColors.blueHeader,
                  ),
                  rows:
                      state is StatisticLoaded
                          ? state.mealStatistics.asMap().entries.map((entry) {
                            final index = entry.key;
                            final meal = entry.value;
                            return _buildTableRow(
                              meal,
                              index + 1,
                              state.mealStatistics.length,
                            );
                          }).toList()
                          : [],
                  isLoading: state is StatisticLoading,
                  emptyState: EmptyState(
                    message: l10n.noData,
                    subMessage: l10n.chooseOtherYear,
                    icon: Icons.bar_chart,
                  ),
                ),
                const SizedBox(height: 16),
                TotalAmountField(
                  amount:
                      state is StatisticLoaded &&
                              state.mealStatistics.isNotEmpty
                          ? NumberFormat('#,###').format(state.totalAmount)
                          : '0',
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTableRow(MealStatistic meal, int index, int length) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
            index == length
                ? const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
                : null,
        border:
            index == length
                ? null
                : const Border(
                  bottom: BorderSide(color: AppColors.grey400, width: 1),
                ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Text(
                index.toString(),
                style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  meal.foodName,
                  style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('d/M/yyyy').format(meal.orderDate),
                style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${NumberFormat('#,###').format(meal.price)} VND',
                style: AppTextStyles.tableCell.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
