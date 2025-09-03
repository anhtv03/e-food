import 'package:e_food/blocs/auth_bloc/register_bloc/register_bloc.dart';
import 'package:e_food/blocs/auth_bloc/register_bloc/register_event.dart';
import 'package:e_food/blocs/auth_bloc/register_bloc/register_state.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_food/l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => RegisterBloc(context: context),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            _showSnackBar(state.message);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.3),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Back button
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              l10n.comeBack,
                              style: AppTextStyles.backButton,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(12),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withValues(
                                      alpha: 0.1,
                                    ),
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
                                        l10n.createAccount,
                                        style: AppTextStyles.authTitle.copyWith(
                                          color: AppColors.greenRegister,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 16),
                                      Divider(
                                        height: 10,
                                        thickness: 1,
                                        color: AppColors.greenRegisterLight,
                                      ),
                                      SizedBox(height: 16),

                                      // Full name field
                                      _buildTextField(
                                        _fullNameController,
                                        l10n.fullName,
                                        false,
                                      ),
                                      SizedBox(height: 8),
                                      if (state is NameError)
                                        _buildTextError(state.message),
                                      SizedBox(height: 8),

                                      // Email field
                                      _buildTextField(
                                        _employeeIdController,
                                        l10n.employeeId,
                                        false,
                                      ),
                                      SizedBox(height: 8),
                                      if (state is EmployeeError)
                                        _buildTextError(state.message),
                                      SizedBox(height: 8),

                                      // Username field
                                      _buildTextField(
                                        _usernameController,
                                        l10n.accountName,
                                        false,
                                      ),
                                      SizedBox(height: 8),
                                      if (state is UsernameError)
                                        _buildTextError(state.message),
                                      SizedBox(height: 8),

                                      // Password field
                                      _buildTextField(
                                        _passwordController,
                                        l10n.password,
                                        true,
                                      ),
                                      SizedBox(height: 8),
                                      if (state is PasswordError)
                                        _buildTextError(state.message),
                                      SizedBox(height: 8),

                                      if (state is RegisterError)
                                        _buildTextError(state.message),
                                      SizedBox(height: 16),

                                      // Register button
                                      _buildRegisterButton(
                                        context,
                                        state,
                                        l10n,
                                      ),
                                    ],
                                  ),
                                  if (state is RegisterLoading)
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
    _fullNameController.dispose();
    _employeeIdController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //========================handle logic==============================
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 3)),
    );
  }

  //========================handle UI==============================
  Widget _buildTextField(controller, hintText, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscurePassword : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.hint,
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

  Widget _buildRegisterButton(
    BuildContext context,
    RegisterState state,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            state is RegisterLoading
                ? null
                : () {
                  context.read<RegisterBloc>().add(
                    RegisterHandleEvent(
                      fullName: _fullNameController.text.trim(),
                      employeeId: _employeeIdController.text.trim(),
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
        child: Text(l10n.register, style: AppTextStyles.buttonLarge),
      ),
    );
  }

  Widget _buildTextError(String? message) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        message ?? '',
        style: AppTextStyles.error,
        textAlign: TextAlign.left,
      ),
    );
  }
}
