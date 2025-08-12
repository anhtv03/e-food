import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/blocs/home_bloc/home_state.dart';
import 'package:e_food/models/meal.dart';
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
      appBar: AppBar(
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting section
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
                      Text(
                        'Lưu ý: đặt cơm chậm nhất trước 10:00 AM',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

    // Check if current time is before 10:00 AM
    final isBeforeDeadline =
        (currentTime.hour < deadlineTime.hour) ||
        (currentTime.hour == deadlineTime.hour &&
            currentTime.minute < deadlineTime.minute);

    // Check if it's the same day as service date
    final isSameDay = currentDate.isAtSameMomentAs(serviceDate);

    // Determine button state
    ButtonState buttonState = _getButtonState(
      meal,
      isSameDay,
      isBeforeDeadline,
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
                width: 180,
                height: 94,
                color: Colors.grey[200],
                child:
                    meal.imageUrl.startsWith('assets/')
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
                  // Action buttons
                  SizedBox(width: 12),
                  Column(children: [_buildActionButton(buttonState, meal)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ButtonState _getButtonState(
    Meal meal,
    bool isSameDay,
    bool isBeforeDeadline,
  ) {
    if (meal.isOrdered) {
      if (isSameDay && isBeforeDeadline) {
        return ButtonState.cancel; // Show "Hủy món" button
      } else {
        return ButtonState.ordered; // Show "Đã đặt" disabled button
      }
    } else {
      if (isSameDay && isBeforeDeadline) {
        return ButtonState.order; // Show "Đặt món" active button
      } else {
        return ButtonState.disabled; // Show "Đặt món" disabled button
      }
    }
  }

  Widget _buildActionButton(ButtonState buttonState, Meal meal) {
    switch (buttonState) {
      case ButtonState.order:
        return ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<HomeBloc>().add(OrderMealEvent(meal: meal));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đặt món "${meal.name}" thành công!')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(1, 157, 219, 1),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text('Đặt món', style: TextStyle(fontSize: 12)),
        );

      case ButtonState.cancel:
        return ElevatedButton(
          onPressed: () => _showCancelConfirmDialog(meal),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text('Hủy món', style: TextStyle(fontSize: 12)),
        );

      case ButtonState.ordered:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Đã đặt',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        );

      case ButtonState.disabled:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Đặt món',
            style: TextStyle(fontSize: 12, color: Colors.white),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hủy món "${meal.name}" thành công!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Xác nhận'),
              ),
            ],
          ),
    );
  }
}

enum ButtonState {
  order, // Đặt món (active)
  cancel, // Hủy món (active)
  ordered, // Đã đặt (disabled)
  disabled, // Đặt món (disabled)
}
