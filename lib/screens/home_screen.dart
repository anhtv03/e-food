import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/blocs/home_bloc/home_state.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/models/meal.dart';
import 'package:e_food/widgets/common/custom_app_drawer.dart';
import 'package:e_food/widgets/common/custom_app_header.dart';
import 'package:e_food/widgets/common/custom_app_menu.dart';
import 'package:e_food/widgets/common/notification_dialog.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/widgets/home/meal_button.dart';
import 'package:e_food/widgets/home/meal_card.dart';
import 'package:e_food/widgets/home/user_greeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(
                  LoadHomeEvent(localizations: l10n),
                );
                await context.read<HomeBloc>().stream.firstWhere(
                  (s) => s is HomeLoaded || s is HomeError,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header name user
                  UserGreeting(userName: state.userName),

                  // Header section
                  AppHeader(
                    title: l10n.weeklyMeals,
                    icon: Icons.restaurant_menu,
                    iconColor: AppColors.orange,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(l10n.noteOrder, style: AppTextStyles.note),
                  ),
                  SizedBox(height: 4),

                  // Meals list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: state.meals.length,
                      itemBuilder: (context, index) {
                        final meal = state.meals[index];
                        return MealCard(
                          meal: meal,
                          actionButtons: MealActionButtons(
                            buttonState: _getButtonState(meal),
                            onOrder: () {
                              context.read<HomeBloc>().add(
                                OrderMealEvent(meal: meal, localizations: l10n),
                              );
                              showSuccessDialog(context, l10n.updateSuccess);
                            },
                            onCancel:
                                () => _showCancelConfirmDialog(meal, l10n),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                        LoadHomeEvent(localizations: l10n),
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

  //========================handle logic==============================
  MealState _getButtonState(Meal meal) {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);
    final serviceDate = DateTime(
      meal.serviceDate.year,
      meal.serviceDate.month,
      meal.serviceDate.day,
    );
    final currentTime = TimeOfDay.fromDateTime(now);
    final deadlineTime = const TimeOfDay(hour: 10, minute: 0);
    final isAfterToday = serviceDate.isAfter(currentDate);
    final isSameDayAndBeforeDeadline =
        serviceDate.isAtSameMomentAs(currentDate) &&
        ((currentTime.hour < deadlineTime.hour) ||
            (currentTime.hour == deadlineTime.hour &&
                currentTime.minute < deadlineTime.minute));

    if (meal.isOrdered) {
      if (isAfterToday || isSameDayAndBeforeDeadline) {
        return MealState.cancel;
      } else {
        return MealState.ordered;
      }
    } else {
      if (isAfterToday || isSameDayAndBeforeDeadline) {
        return MealState.order;
      } else {
        return MealState.disabled;
      }
    }
  }

  void _showCancelConfirmDialog(Meal meal, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.confirmCancel, style: AppTextStyles.heading4),
            content: Text(
              l10n.confirmMsgCancel(meal.name),
              style: AppTextStyles.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.unconfirm, style: AppTextStyles.linkText),
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
                child: Text(
                  l10n.confirm,
                  style: AppTextStyles.buttonMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
