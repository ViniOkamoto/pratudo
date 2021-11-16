import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class AppField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final double verticalPadding;
  final double horizontalPadding;
  final bool isBigTextField;
  final TextStyle? Function({dynamic color})? fieldTextStyle;

  AppField({
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.suffixIcon,
    this.inputFormatters,
    this.onSubmitted,
    this.focusNode,
    this.prefixIcon,
    this.errorText,
    this.verticalPadding = 11,
    this.horizontalPadding = 16,
    this.obscureText = false,
    this.isBigTextField = false,
    this.fieldTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      maxLines: isBigTextField ? null : 1,
      textAlignVertical: TextAlignVertical.center,
      style: fieldTextStyle != null
          ? fieldTextStyle!(color: AppColors.darkestColor)
          : AppTypo.p2(color: AppColors.darkestColor),
      decoration: InputDecoration(
        fillColor: AppColors.lightestGrayColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(horizontalPadding),
          vertical: SizeConverter.relativeWidth(verticalPadding),
        ),
        isDense: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: fieldTextStyle != null
            ? fieldTextStyle!(color: AppColors.lightGrayColor)
            : AppTypo.p2(color: AppColors.lightGrayColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightestGrayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightestGrayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightestGrayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorText: errorText,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightestGrayColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: AppTypo.p3(
          color: AppColors.redColor,
        ),
      ),
    );
  }
}
