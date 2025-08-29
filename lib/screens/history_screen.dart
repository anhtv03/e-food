import 'package:e_food/blocs/history_bloc/history_bloc.dart';
import 'package:e_food/blocs/history_bloc/history_event.dart';
import 'package:e_food/blocs/history_bloc/history_state.dart';
import 'package:e_food/models/history.dart';
import 'package:e_food/widgets/common/custom_app_drawer.dart';
import 'package:e_food/widgets/common/custom_app_menu.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(LoadHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
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
            return Center(child: CircularProgressIndicator());
          }

          if (state is HistoryLoaded) {
            return RefreshIndicator(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      color: AppColors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.blue,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Lịch sử đặt món',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
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

                    // History table
                    _buildHistoryTable(state),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              onRefresh: () async {
                context.read<HistoryBloc>().add(LoadHistoryEvent());
                await context.read<HistoryBloc>().stream.firstWhere(
                  (s) => s is HistoryLoaded || s is HistoryError,
                );
              },
            );
          }

          if (state is HistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.grey400),
                  SizedBox(height: 16),
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 16, color: AppColors.grey600),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HistoryBloc>().add(LoadHistoryEvent());
                    },
                    child: Text('Thử lại'),
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

  //========================handle UI==============================
  Widget _buildHistoryTable(state) {
    return Center(
      child: Container(
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
            _buildTableHeader(),

            // Table content
            state.orderHistory.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.orderHistory.length,
                  itemBuilder: (context, index) {
                    final order = state.orderHistory[index];
                    return _buildTableRow(
                      order,
                      index + 1,
                      state.orderHistory.length,
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.green600,
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
            width: 40,
            child: Text(
              'STT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Tên món
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Tên món',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          // Ngày cung cấp
          Expanded(
            flex: 2,
            child: Text(
              'Ngày cung cấp',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Trạng thái
          Expanded(
            flex: 2,
            child: Text(
              'Trạng thái',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(OrderHistory order, int index, int length) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? AppColors.grey50 : AppColors.white,
        borderRadius:
            index == length
                ? BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
                : null,
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
              width: 40,
              child: Text(
                index.toString(),
                style: TextStyle(fontSize: 14, color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),

            // Tên món
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  order.mealName,
                  style: TextStyle(fontSize: 14, color: AppColors.black),
                ),
              ),
            ),

            // Ngày cung cấp
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('d/M/yyyy').format(order.serviceDate),
                style: TextStyle(fontSize: 14, color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),

            // Trạng thái
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(order.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: AppColors.grey400),
          SizedBox(height: 16),
          Text(
            'Chưa có lịch sử đặt món',
            style: TextStyle(fontSize: 16, color: AppColors.grey600),
          ),
          SizedBox(height: 8),
          Text(
            'Hãy đặt món đầu tiên của bạn!',
            style: TextStyle(fontSize: 14, color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}

String _getStatusText(OrderStatus status) {
  switch (status) {
    case OrderStatus.completed:
      return 'Đã đặt';
    case OrderStatus.cancelled:
      return 'Đã hủy';
    case OrderStatus.pending:
      return 'Chờ xử lý';
  }
}
