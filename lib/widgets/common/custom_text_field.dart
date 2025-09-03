import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class CustomTextField {
  static Widget buildTextField(
    TextEditingController controller,
    String hintText,
    bool isPassword,
  ) {
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

  static Widget buildTextError(String? message, bool isCenter) {
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
