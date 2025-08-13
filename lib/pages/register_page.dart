import 'package:e_food/blocs/auth_bloc/register_bloc/register_bloc.dart';
import 'package:e_food/blocs/auth_bloc/register_bloc/register_event.dart';
import 'package:e_food/blocs/auth_bloc/register_bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => RegisterBloc(),
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
                  color: Colors.black.withValues(alpha: 0.3),
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
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Quay lại',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(12),
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Container(
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
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
                                          'Tạo tài khoản mới',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                              0,
                                              176,
                                              35,
                                              1,
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 16),
                                        Divider(
                                          height: 10,
                                          thickness: 1,
                                          color: Color.fromRGBO(
                                            0,
                                            176,
                                            35,
                                            0.5,
                                          ),
                                        ),
                                        SizedBox(height: 16),

                                        // Full name field
                                        _buildTextField(
                                          _fullNameController,
                                          'Tên đầy đủ',
                                          false,
                                        ),
                                        SizedBox(height: 8),
                                        if (state is NameError)
                                          _buildTextError(state.message),
                                        SizedBox(height: 8),

                                        // Email field
                                        _buildTextField(
                                          _employeeIdController,
                                          'Mã nhân viên',
                                          false,
                                        ),
                                        SizedBox(height: 8),
                                        if (state is EmployeeError)
                                          _buildTextError(state.message),
                                        SizedBox(height: 8),

                                        // Username field
                                        _buildTextField(
                                          _usernameController,
                                          'Tên tài khoản',
                                          false,
                                        ),
                                        SizedBox(height: 8),
                                        if (state is UsernameError)
                                          _buildTextError(state.message),
                                        SizedBox(height: 8),

                                        // Password field
                                        _buildTextField(
                                          _passwordController,
                                          'Mật khẩu',
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
                                        _buildRegisterButton(context, state),
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
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
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

  Widget _buildRegisterButton(BuildContext context, RegisterState state) {
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
          backgroundColor: Color.fromRGBO(0, 161, 205, 1),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Đăng ký',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTextError(String? message) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        message ?? '',
        style: TextStyle(
          fontSize: 12,
          height: 1,
          color: Color.fromRGBO(236, 70, 34, 1),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
