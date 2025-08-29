import 'package:e_food/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_event.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_state.dart';
import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/screens/home_screen.dart';
import 'package:e_food/screens/register_screen.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_food/l10n/app_localizations.dart';

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
      create: (context) => LoginBloc(),
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
          final l10n = AppLocalizations.of(context);
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_1.jpg'),
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header
                              Text(
                                l10n.loginTitle,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                l10n.subLoginTitle,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.grey600,
                                ),
                              ),
                              SizedBox(height: 32),

                              // Username field
                              _buildTextField(
                                _usernameController,
                                l10n.placeholderUsername,
                                false,
                              ),
                              SizedBox(height: 8),
                              if (state is UsernameError)
                                _buildTextError(state.message, false),
                              SizedBox(height: 8),

                              // Password field
                              _buildTextField(
                                _passwordController,
                                l10n.placeholderPassword,
                                true,
                              ),
                              SizedBox(height: 8),
                              if (state is PasswordError)
                                _buildTextError(state.message, false),
                              SizedBox(height: 8),

                              //Error field
                              if (state is LoginError)
                                _buildTextError(state.message, true),
                              SizedBox(height: 16),

                              // Login button
                              _buildLoginButton(context, state, l10n),
                              SizedBox(height: 8),

                              // Forgot password
                              SizedBox(
                                height: 35,
                                child: TextButton(
                                  onPressed: () {
                                    _handleForgotPassword();
                                  },
                                  child: Text(
                                    l10n.forgotPassword,
                                    style: TextStyle(
                                      color: AppColors.teal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Divider(
                                height: 10,
                                thickness: 1,
                                color: AppColors.darkGreen,
                              ),

                              SizedBox(height: 8),
                              // Register button
                              _buildRegisterButton(l10n),
                            ],
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
  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chức năng quên mật khẩu'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  //========================handle UI==============================
  Widget _buildTextField(controller, hintText, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscurePassword : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.grey400),
        filled: true,
        fillColor: AppColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.teal, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey400,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
                : null,
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context,
    LoginState state,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed:
            state is LoginLoading
                ? null
                : () {
                  context.read<LoginBloc>().add(
                    LoginHandleEvent(
                      username: _usernameController.text.trim(),
                      password: _passwordController.text,
                    ),
                  );
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightBlueLogin,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          l10n.login,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(AppLocalizations l10n) {
    return SizedBox(
      width: 222,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegister,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          l10n.createAccount,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTextError(String? message, bool isCenter) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        message ?? '',
        style: TextStyle(fontSize: 12, height: 1, color: AppColors.errorRed),
        textAlign: isCenter ? TextAlign.center : TextAlign.left,
      ),
    );
  }
}
