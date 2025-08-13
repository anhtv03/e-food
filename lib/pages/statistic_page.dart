import 'package:e_food/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_event.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_state.dart';
import 'package:e_food/models/meal_statistic.dart';
import 'package:e_food/pages/modal/app_drawer.dart';
import 'package:e_food/pages/modal/app_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                  color: Colors.white,
                  child: Row(
                    children: [
                      Icon(Icons.bar_chart, color: Colors.blue, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Thống kê suất ăn',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
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
                  color: Color.fromRGBO(9, 50, 0, 1),
                ),
                SizedBox(height: 16),

                // Filter section
                _buildFilterField(),
                SizedBox(height: 16),

                // Statistics table
                _buildStatisticTable(state),
                SizedBox(height: 16),

                // Total amount section
                _buildTotalAmountField(state),
              ],
            );
          },
        ),
      ),
    );
  }

  //========================handle UI==============================
  Widget _buildFilterField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          // Month dropdown
          Text(
            'Tháng',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.only(left: 18),
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedMonth,
                items:
                    months.map((month) {
                      return DropdownMenuItem<int>(
                        value: month,
                        child: Text(month.toString()),
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
            'Năm',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.only(left: 18),
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedYear,
                items:
                    years.map((year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
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
                backgroundColor: Color.fromRGBO(78, 137, 255, 1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text('Tìm kiếm', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticTable(state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
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
          if (state is StatisticLoading)
            Container(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (state is StatisticLoaded)
            state.mealStatistics.isEmpty
                ? _buildEmptyState()
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
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        border: Border(
          bottom: BorderSide(color: Colors.grey[400]!, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // STT
          SizedBox(
            width: 30,
            child: Text(
              'STT',
              style: TextStyle(
                fontSize: 12,
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
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Tên món',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Giá (VNĐ)
          Expanded(
            flex: 2,
            child: Text(
              'Giá (VNĐ)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Ngày cung cấp
          Expanded(
            flex: 2,
            child: Text(
              'Ngày cung cấp',
              style: TextStyle(
                fontSize: 12,
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

  Widget _buildTableRow(MealStatistic meal, int index, int length) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.grey[50] : Colors.white,
        border:
            index == length
                ? null
                : Border(
                  bottom: BorderSide(color: Colors.grey[400]!, width: 1),
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
                style: TextStyle(fontSize: 12, color: Colors.black87),
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
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
            ),

            // Giá (VNĐ)
            Expanded(
              flex: 2,
              child: Text(
                '${NumberFormat('#,###').format(meal.price)} VND',
                style: TextStyle(fontSize: 12, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),

            // Ngày cung cấp
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('d/M/yyyy').format(meal.serviceDate),
                style: TextStyle(fontSize: 12, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'Không có dữ liệu thống kê',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Hãy chọn tháng/năm khác để xem thống kê',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountField(state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      // padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tổng tiền trong tháng: '
            '${(state is StatisticLoaded && state.mealStatistics.isNotEmpty) ? '${NumberFormat('#,###').format(state.totalAmount)} VND' : '0 VND'}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
