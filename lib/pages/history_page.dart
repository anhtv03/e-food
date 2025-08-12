import 'package:e_food/blocs/history_bloc/history_bloc.dart';
import 'package:e_food/blocs/history_bloc/history_event.dart';
import 'package:e_food/blocs/history_bloc/history_state.dart';
import 'package:e_food/models/history.dart';
import 'package:e_food/pages/modal/app_drawer.dart';
import 'package:e_food/pages/modal/app_menu.dart';
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
      backgroundColor: Colors.grey[100],
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Lịch sử đặt món',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),

                // History table
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Table header
                        _buildTableHeader(),

                        // Divider
                        Divider(height: 1, color: Colors.grey[300]),

                        // Table content
                        Expanded(
                          child:
                              state.orderHistory.isEmpty
                                  ? _buildEmptyState()
                                  : ListView.builder(
                                    itemCount: state.orderHistory.length,
                                    itemBuilder: (context, index) {
                                      final order = state.orderHistory[index];
                                      return _buildTableRow(order, index + 1);
                                    },
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            );
          }

          if (state is HistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green[600],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          // STT
          Container(
            width: 40,
            child: Text(
              'STT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                  color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(OrderHistory order, int index) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.grey[50] : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            // STT
            Container(
              width: 40,
              child: Text(
                index.toString(),
                style: TextStyle(fontSize: 14, color: Colors.black87),
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
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),

            // Ngày cung cấp
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('d/M/yyyy').format(order.serviceDate),
                style: TextStyle(fontSize: 14, color: Colors.black87),
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
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(order.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
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
          Icon(Icons.history, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Chưa có lịch sử đặt món',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Hãy đặt món đầu tiên của bạn!',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.pending:
        return Colors.orange;
      default:
        return Colors.grey;
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
      default:
        return 'Không xác định';
    }
  }
}
