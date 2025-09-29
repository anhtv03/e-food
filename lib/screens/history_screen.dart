import 'package:e_food/blocs/history_bloc/history_bloc.dart';
import 'package:e_food/blocs/history_bloc/history_event.dart';
import 'package:e_food/blocs/history_bloc/history_state.dart';
import 'package:e_food/constants/app_assets.dart';
import 'package:e_food/models/history.dart';
import 'package:e_food/widgets/common/custom_app_drawer.dart';
import 'package:e_food/widgets/common/custom_app_header.dart';
import 'package:e_food/widgets/common/custom_app_menu.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/widgets/common/custom_app_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:e_food/l10n/app_localizations.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context);
      context.read<HistoryBloc>().add(LoadHistoryEvent(localizations: l10n));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppMenu(),
      endDrawer: AppDrawer(page: "history"),
      body: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is HistoryLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HistoryBloc>().add(
                  RefreshHistoryEvent(localizations: l10n),
                );
                await context.read<HistoryBloc>().stream.firstWhere(
                  (s) => s is HistoryLoaded || s is HistoryError,
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHeader(
                      title: l10n.orderHistory,
                      iconPath: AppAssets.historyIcon,
                      iconColor: AppColors.orange,
                    ),
                    const Divider(
                      height: 10,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                      color: AppColors.darkGreen,
                    ),
                    const SizedBox(height: 16),
                    AppTable(
                      header: TableHeader(
                        noLabel: l10n.no,
                        dishNameLabel: l10n.dishName,
                        dateLabel: l10n.supplyDate,
                        thirdColumnLabel: l10n.status,
                        headerColor: AppColors.green600,
                      ),
                      rows:
                          state.orderHistory.asMap().entries.map((entry) {
                            final index = entry.key;
                            final order = entry.value;
                            return _buildTableRow(
                              order,
                              index + 1,
                              state.orderHistory.length,
                              l10n,
                            );
                          }).toList(),
                      isLoading: false,
                      emptyState: EmptyState(
                        message: l10n.noData,
                        subMessage: l10n.noOrdered,
                        icon: Icons.history,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }
          if (state is HistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.grey400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HistoryBloc>().add(
                        LoadHistoryEvent(localizations: l10n),
                      );
                    },
                    child: Text(l10n.search, style: AppTextStyles.buttonMedium),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildTableRow(
    OrderHistory order,
    int index,
    int length,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? AppColors.grey200 : AppColors.white,
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
                style: AppTextStyles.tableCell,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(order.foodName, style: AppTextStyles.tableCell),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('d/M/yyyy').format(order.orderDate),
                style: AppTextStyles.tableCell,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status == "ordered" ? l10n.ordered : l10n.order,
                    style: AppTextStyles.bodyXSmall.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
