import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:e_food/l10n/app_localizations.dart';
import '../../constants/app_colors.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onRegister;
  final bool isLoading;
  final String? usernameError;
  final String? passwordError;
  final String? generalError;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.onRegister,
    this.isLoading = false,
    this.usernameError,
    this.passwordError,
    this.generalError,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Text(
          l10n.loginTitle,
          style: AppTextStyles.authTitle.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Text(l10n.subLoginTitle, style: AppTextStyles.authSubtitle),
        const SizedBox(height: 32),

        // Username field
        _buildTextField(usernameController, l10n.placeholderUsername, false),
        const SizedBox(height: 8),
        if (usernameError != null) _buildTextError(usernameError!, false),
        const SizedBox(height: 8),

        // Password field
        _buildTextField(passwordController, l10n.placeholderPassword, true),
        const SizedBox(height: 8),
        if (passwordError != null) _buildTextError(passwordError!, false),
        const SizedBox(height: 8),

        // General error
        if (generalError != null) _buildTextError(generalError!, true),
        const SizedBox(height: 16),

        // Login button
        _buildLoginButton(
          l10n.login,
          isLoading ? null : onLogin,
          AppColors.lightBlueLogin,
          isLoading,
        ),
        const SizedBox(height: 8),

        // Forgot password
        SizedBox(
          height: 35,
          child: Text(l10n.forgotPassword, style: AppTextStyles.linkText),
        ),
        const SizedBox(height: 8),

        // Divider
        const Divider(height: 10, thickness: 1, color: AppColors.darkGreen),

        // Register button
        SizedBox(height: 8),
        _buildRegisterButton(l10n.createAccount, onRegister),
      ],
    );
  }

  //========================handle UI==============================
  Widget _buildTextField(controller, hintText, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
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

  Widget _buildLoginButton(
    String text,
    VoidCallback? onPressed,
    Color backgroundColor,
    bool isLoading,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
                : Text(text, style: AppTextStyles.buttonLarge),
      ),
    );
  }

  Widget _buildRegisterButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 222,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenRegister,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(text, style: AppTextStyles.buttonLarge),
      ),
    );
  }
}
