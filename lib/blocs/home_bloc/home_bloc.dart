import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/blocs/home_bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {}
}
