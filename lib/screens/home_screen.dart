import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/blocs/home_bloc/home_state.dart';
import 'package:e_food/models/meal.dart';
import 'package:e_food/widgets/common/custom_app_drawer.dart';
import 'package:e_food/widgets/common/custom_app_menu.dart';
import 'package:e_food/widgets/common/notification_dialog.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:e_food/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context);
      context.read<HomeBloc>().add(LoadHomeEvent(localizations: l10n));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.grey100,
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
                    color: AppColors.white,
                    child: Text(
                      l10n.welcomeUser(state.userName),
                      style: TextStyle(fontSize: 16, color: AppColors.grey700),
                    ),
                  ),

                  // Header section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: AppColors.orange,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              l10n.weeklyMeals,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: AppColors.darkGreen,
                        ),
                        SizedBox(height: 4),
                        Text(
                          l10n.noteOrder,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
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
                        return _buildMealCard(meal, l10n);
                      },
                    ),
                  ),
                ],
              ),
              onRefresh: () async {
                context.read<HomeBloc>().add(
                  LoadHomeEvent(localizations: l10n),
                );
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
                      context.read<HomeBloc>().add(
                        LoadHomeEvent(localizations: l10n),
                      );
                    },
                    child: Text(l10n.search),
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
  Widget _buildMealCard(Meal meal, AppLocalizations l10n) {
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.1),
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
                color: AppColors.grey200,
                child:
                    meal.imageUrl.startsWith('assets')
                        ? Image.asset(
                          meal.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.grey300,
                              child: Icon(
                                Icons.restaurant,
                                color: AppColors.grey600,
                                size: 40,
                              ),
                            );
                          },
                        )
                        : Container(
                          color: AppColors.grey300,
                          child: Icon(
                            Icons.restaurant,
                            color: AppColors.grey600,
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
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    l10n.formatAmount(NumberFormat('#,###').format(meal.price)),
                    style: TextStyle(fontSize: 13, color: AppColors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    l10n.formatDate(
                      DateFormat('dd/MM/yyyy').format(meal.serviceDate),
                    ),
                    style: TextStyle(fontSize: 13, color: AppColors.black),
                  ),
                  SizedBox(height: 8),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildCancelButton(buttonState, meal, l10n),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildOrderButton(buttonState, meal, l10n),
                      ),
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

  Widget _buildCancelButton(
    MealState buttonState,
    Meal meal,
    AppLocalizations l10n,
  ) {
    bool isEnabled = (buttonState == MealState.cancel);

    return SizedBox(
      height: 27,
      child: ElevatedButton(
        onPressed:
            isEnabled ? () => _showCancelConfirmDialog(meal, l10n) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.red : AppColors.grey,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: isEnabled ? 2 : 0,
        ),
        child: Text(l10n.cancel, style: TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildOrderButton(
    MealState buttonState,
    Meal meal,
    AppLocalizations l10n,
  ) {
    switch (buttonState) {
      case MealState.order:
        return SizedBox(
          height: 27,
          child: ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                OrderMealEvent(meal: meal, localizations: l10n),
              );
              showSuccessDialog(context, l10n.updateSuccess);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightBlue,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(l10n.order, style: TextStyle(fontSize: 12)),
          ),
        );

      case MealState.cancel:
      case MealState.ordered:
        return Container(
          height: 27,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              l10n.ordered,
              style: TextStyle(fontSize: 12, color: AppColors.white),
            ),
          ),
        );

      case MealState.disabled:
        return Container(
          height: 27,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              l10n.order,
              style: TextStyle(fontSize: 12, color: AppColors.white),
            ),
          ),
        );
    }
  }

  void _showCancelConfirmDialog(Meal meal, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.confirmCancel),
            content: Text(l10n.confirmMsgCancel(meal.name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.unconfirm),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<HomeBloc>().add(
                    CancelMealEvent(meal: meal, localizations: l10n),
                  );
                  showSuccessDialog(context, l10n.updateSuccess);
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                child: Text(l10n.confirm),
              ),
            ],
          ),
    );
  }
}
