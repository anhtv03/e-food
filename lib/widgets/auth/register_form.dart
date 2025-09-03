import 'package:e_food/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:e_food/l10n/app_localizations.dart';
import '../../constants/app_colors.dart';
import 'package:e_food/widgets/common/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController employeeIdController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onRegister;
  final bool isLoading;
  final String? nameError;
  final String? employeeError;
  final String? usernameError;
  final String? passwordError;
  final String? generalError;

  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.employeeIdController,
    required this.usernameController,
    required this.passwordController,
    required this.onRegister,
    this.isLoading = false,
    this.nameError,
    this.employeeError,
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
          l10n.createAccount,
          style: AppTextStyles.authTitle.copyWith(
            color: AppColors.greenRegister,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Divider(
          height: 10,
          thickness: 1,
          color: AppColors.greenRegisterLight,
        ),
        const SizedBox(height: 16),

        // Full name field
        CustomTextField.buildTextField(
          fullNameController,
          l10n.fullName,
          false,
        ),
        const SizedBox(height: 8),
        if (nameError != null) CustomTextField.buildTextError(nameError, false),
        const SizedBox(height: 8),

        // Employee ID field
        CustomTextField.buildTextField(
          employeeIdController,
          l10n.employeeId,
          false,
        ),
        const SizedBox(height: 8),
        if (employeeError != null)
          CustomTextField.buildTextError(employeeError, false),
        const SizedBox(height: 8),

        // Username field
        CustomTextField.buildTextField(
          usernameController,
          l10n.accountName,
          false,
        ),
        const SizedBox(height: 8),
        if (usernameError != null)
          CustomTextField.buildTextError(usernameError, false),
        const SizedBox(height: 8),

        // Password field
        CustomTextField.buildTextField(passwordController, l10n.password, true),
        const SizedBox(height: 8),
        if (passwordError != null)
          CustomTextField.buildTextError(passwordError, false),
        const SizedBox(height: 8),

        // General error
        if (generalError != null)
          CustomTextField.buildTextError(generalError, false),
        const SizedBox(height: 16),

        // Register button
        _buildRegisterButton(l10n.register, isLoading ? null : onRegister),
      ],
    );
  }

  //========================handle UI==============================
  Widget _buildRegisterButton(String text, VoidCallback? onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
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
