import 'package:e_food/blocs/history_bloc/history_bloc.dart';
import 'package:e_food/blocs/history_bloc/history_event.dart';
import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_event.dart';
import 'package:e_food/pages/home_page.dart';
import 'package:e_food/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(const LoadHomeEvent()),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc()..add(const LoadHistoryEvent()),
        ),
        BlocProvider<StatisticBloc>(
          create:
              (context) =>
                  StatisticBloc()
                    ..add(LoadStatisticEvent(month: now.month, year: now.year)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: _checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData && snapshot.data == true) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    // String? token = await TokenService.getToken('user');
    // return token != null && token.isNotEmpty;
    return false;
  }
}
