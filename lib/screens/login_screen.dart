import 'package:e_food/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_event.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_state.dart';
import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/constants/app_assets.dart';
import 'package:e_food/screens/home_screen.dart';
import 'package:e_food/screens/register_screen.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/widgets/auth/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context: context),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.read<HomeBloc>().add(LoadHomeEvent());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundLogin),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.3),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 100, horizontal: 12),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          LoginForm(
                            usernameController: _usernameController,
                            passwordController: _passwordController,
                            onLogin: () => _handleLogin(context),
                            onRegister: _handleNavigateToRegister,
                            isLoading: state is LoginLoading,
                            usernameError:
                                state is UsernameError ? state.message : null,
                            passwordError:
                                state is PasswordError ? state.message : null,
                            generalError:
                                state is LoginError ? state.message : null,
                          ),
                          if (state is LoginLoading)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //========================handle logic==============================
  void _handleNavigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void _handleLogin(BuildContext context) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    context.read<LoginBloc>().add(
      LoginHandleEvent(username: username, password: password),
    );
  }
}
