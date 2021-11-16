import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';

class OutlinedTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? errorText;
  final TextInputAction? textInputAction;
  final bool isBigTextField;

  const OutlinedTextField({
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.errorText,
    this.textInputAction,
    this.isBigTextField = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTypo.h2(color: AppColors.darkestColor),
      maxLines: isBigTextField ? null : 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: AppTypo.p2(color: AppColors.lightGrayColor),
        errorStyle: AppTypo.p2(color: AppColors.redColor),
        errorText: errorText,
      ),
    );
  }
}
