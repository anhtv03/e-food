import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/blocs/home_bloc/home_state.dart';
import 'package:e_food/models/meal.dart';
import 'package:e_food/pages/modal/app_drawer.dart';
import 'package:e_food/pages/modal/app_menu.dart';
import 'package:e_food/pages/modal/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppMenu(),
      endDrawer: AppDrawer(page: "home"),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            return RefreshIndicator(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header name user
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Text(
                      'Xin chào, ${state.userName}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ),

                  // Header section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.orange,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Món ăn trong tuần này',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Color.fromRGBO(9, 50, 0, 1),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lưu ý: đặt cơm chậm nhất trước 10:00 AM',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),

                  // Meals list
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      itemCount: state.meals.length,
                      itemBuilder: (context, index) {
                        final meal = state.meals[index];
                        return _buildMealCard(meal);
                      },
                    ),
                  ),
                ],
              ),
              onRefresh: () async {
                context.read<HomeBloc>().add(LoadHomeEvent());
                await context.read<HomeBloc>().stream.firstWhere(
                  (s) => s is HomeLoaded || s is HomeError,
                );
              },
            );
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(LoadHomeEvent());
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

  //========================handle logic==============================
  MealState _getButtonState(
    Meal meal,
    bool isAfterToday,
    bool isSameDayAndBeforeDeadline,
  ) {
    if (meal.isOrdered) {
      if (isAfterToday || isSameDayAndBeforeDeadline) {
        return MealState.cancel; // "Cancel" is available
      } else {
        return MealState.ordered; // "Ordered" is not available
      }
    } else {
      if (isAfterToday || isSameDayAndBeforeDeadline) {
        return MealState.order; // "Order" is available
      } else {
        return MealState.disabled; // "Order" is not available
      }
    }
  }

  //========================handle UI==============================
  Widget _buildMealCard(Meal meal) {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);
    final serviceDate = DateTime(
      meal.serviceDate.year,
      meal.serviceDate.month,
      meal.serviceDate.day,
    );
    final currentTime = TimeOfDay.fromDateTime(now);
    final deadlineTime = TimeOfDay(hour: 10, minute: 0);
    final isAfterToday = serviceDate.isAfter(currentDate);
    final isSameDayAndBeforeDeadline =
        serviceDate.isAtSameMomentAs(currentDate) &&
        ((currentTime.hour < deadlineTime.hour) ||
            (currentTime.hour == deadlineTime.hour &&
                currentTime.minute < deadlineTime.minute));

    MealState buttonState = _getButtonState(
      meal,
      isAfterToday,
      isSameDayAndBeforeDeadline,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 6),
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
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Meal image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 150,
                height: 94,
                color: Colors.grey[200],
                child:
                    meal.imageUrl.startsWith('assets')
                        ? Image.asset(
                          meal.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.restaurant,
                                color: Colors.grey[600],
                                size: 40,
                              ),
                            );
                          },
                        )
                        : Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.grey[600],
                            size: 40,
                          ),
                        ),
              ),
            ),
            SizedBox(width: 12),

            // Meal info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Giá: ${NumberFormat('#,###').format(meal.price)}₫',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ngày: ${DateFormat('dd/MM/yyyy').format(meal.serviceDate)}',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(child: _buildCancelButton(buttonState, meal)),
                      SizedBox(width: 8),
                      Expanded(child: _buildOrderButton(buttonState, meal)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(MealState buttonState, Meal meal) {
    bool isEnabled = (buttonState == MealState.cancel);

    return SizedBox(
      height: 27,
      child: ElevatedButton(
        onPressed: isEnabled ? () => _showCancelConfirmDialog(meal) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.red : Colors.grey,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: isEnabled ? 2 : 0,
        ),
        child: Text('Hủy món', style: TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildOrderButton(MealState buttonState, Meal meal) {
    switch (buttonState) {
      case MealState.order:
        return SizedBox(
          height: 27,
          child: ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(OrderMealEvent(meal: meal));
              showSuccessDialog(context, "Cập nhật thành công");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(1, 157, 219, 1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Đặt món', style: TextStyle(fontSize: 12)),
          ),
        );

      case MealState.cancel:
      case MealState.ordered:
        return Container(
          height: 27,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Đã đặt',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        );

      case MealState.disabled:
        return Container(
          height: 27,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Đặt món',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        );
    }
  }

  void _showCancelConfirmDialog(Meal meal) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Xác nhận hủy món'),
            content: Text(
              'Bạn có chắc chắn muốn hủy món "${meal.name}" không?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Không'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<HomeBloc>().add(CancelMealEvent(meal: meal));
                  showSuccessDialog(context, "Cập nhật thành công");
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Xác nhận'),
              ),
            ],
          ),
    );
  }
}
