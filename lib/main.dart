import 'package:e_food/blocs/history_bloc/history_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_event.dart';
import 'package:e_food/l10n/app_localizations.dart';
import 'package:e_food/screens/home_screen.dart';
import 'package:e_food/screens/login_screen.dart';
import 'package:e_food/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    Locale locale = const Locale('vi');
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<HistoryBloc>(create: (context) => HistoryBloc()),
        BlocProvider<StatisticBloc>(
          create:
              (context) =>
                  StatisticBloc()
                    ..add(LoadStatisticEvent(month: now.month, year: now.year)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi'), // Vietnamese
          Locale('en'), // English
        ],
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
    String? token = await TokenService.getToken('user');
    return token != null && token.isNotEmpty;
  }
}
