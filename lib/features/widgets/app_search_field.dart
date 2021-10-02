import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class AppSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onPressedIcon;
  final Function(String)? onSubmitted;

  const AppSearchField({
    required this.hintText,
    required this.textEditingController,
    required this.onChanged,
    this.onPressedIcon,
    this.inputFormatters,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      style: AppTypo.p2(color: AppColors.darkestColor),
      decoration: InputDecoration(
        fillColor: AppColors.lightestGrayColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(16),
          vertical: SizeConverter.relativeWidth(11),
        ),
        isDense: true,
        hintText: hintText,
        prefixIcon: Icon(
          LineAwesomeIcons.search,
          color: AppColors.lightHighlightColor,
          size: SizeConverter.fontSize(24),
        ),
        hintStyle: AppTypo.p2(color: AppColors.lightGrayColor),
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
