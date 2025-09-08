import 'package:e_food/blocs/auth_bloc/register_bloc/register_bloc.dart';
import 'package:e_food/blocs/auth_bloc/register_bloc/register_event.dart';
import 'package:e_food/blocs/auth_bloc/register_bloc/register_state.dart';
import 'package:e_food/constants/app_assets.dart';
import 'package:e_food/constants/app_colors.dart';
import 'package:e_food/constants/app_text_styles.dart';
import 'package:e_food/widgets/auth/register_form.dart';
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(seconds: 2),
              ),
            );
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
                  image: AssetImage(AppAssets.backgroundRegister),
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
                                  RegisterForm(
                                    fullNameController: _fullNameController,
                                    employeeIdController: _employeeIdController,
                                    usernameController: _usernameController,
                                    passwordController: _passwordController,
                                    onRegister: () => _handleRegister(context),
                                    isLoading: state is RegisterLoading,
                                    nameError:
                                        state is NameError
                                            ? state.message
                                            : null,
                                    employeeError:
                                        state is EmployeeError
                                            ? state.message
                                            : null,
                                    usernameError:
                                        state is UsernameError
                                            ? state.message
                                            : null,
                                    passwordError:
                                        state is PasswordError
                                            ? state.message
                                            : null,
                                    generalError:
                                        state is RegisterError
                                            ? state.message
                                            : null,
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
  void _handleRegister(BuildContext context) {
    context.read<RegisterBloc>().add(
      RegisterHandleEvent(
        fullName: _fullNameController.text.trim(),
        employeeId: _employeeIdController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }
}
