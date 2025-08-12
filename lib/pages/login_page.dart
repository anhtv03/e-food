import 'package:e_food/blocs/auth_bloc/login_bloc/login_bloc.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_event.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_state.dart';
import 'package:e_food/blocs/home_bloc/home_bloc.dart';
import 'package:e_food/blocs/home_bloc/home_event.dart';
import 'package:e_food/pages/home_page.dart';
import 'package:e_food/pages/register_page.dart';
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
                  color: Colors.black.withValues(alpha: 0.3),
                ),
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
                              color: Colors.black.withValues(alpha: 0.1),
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
                                  'Xin chào!',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Đăng nhập để tiếp tục',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 32),

                                // Username field
                                _buildTextField(
                                  _usernameController,
                                  'Tên đăng nhập',
                                  false,
                                ),
                                SizedBox(height: 16),

                                // Password field
                                _buildTextField(
                                  _passwordController,
                                  'Mật khẩu',
                                  true,
                                ),
                                SizedBox(height: 16),

                                if (state is LoginError)
                                  _buildTextError(state.message),
                                SizedBox(height: 16),

                                // Login button
                                _buildLoginButton(context, state),
                                SizedBox(height: 16),

                                // Forgot password
                                TextButton(
                                  onPressed: () {
                                    _handleForgotPassword();
                                  },
                                  child: Text(
                                    'Quên mật khẩu?',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Divider(
                                  height: 10,
                                  thickness: 1,
                                  color: Color.fromRGBO(9, 50, 0, 1),
                                ),

                                SizedBox(height: 8),
                                // Register button
                                _buildRegisterButton(),
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
    _showSnackBar('Chức năng quên mật khẩu');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
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

  Widget _buildLoginButton(BuildContext context, LoginState state) {
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
          backgroundColor: Color.fromRGBO(0, 161, 205, 1),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
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
          backgroundColor: Color.fromRGBO(0, 176, 35, 1),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Tạo tài khoản mới',
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
        textAlign: TextAlign.center,
      ),
    );
  }
}
