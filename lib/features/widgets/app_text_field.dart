import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

import 'app_field.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? labelText;
  final bool isOptional;
  final bool isObscure;
  final bool isPassword;
  final Function()? onPressedIcon;
  final bool isBigText;
  final double verticalPadding;
  final double horizontalPadding;
  final TextStyle? Function({dynamic color})? fieldTextStyle;
  final Widget? prefixIcon;
  final FocusNode? focusNode;

  const AppTextField({
    required this.hintText,
    required this.textEditingController,
    required this.onChanged,
    this.onPressedIcon,
    this.inputFormatters,
    this.errorText,
    this.isObscure = false,
    this.isOptional = false,
    this.isPassword = false,
    this.labelText,
    this.isBigText = false,
    this.verticalPadding = 14,
    this.horizontalPadding = 16,
    this.fieldTextStyle,
    this.prefixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText!,
                style: AppTypo.p3(
                  color: errorText != null ? AppColors.redColor : AppColors.darkColor,
                ),
              ),
              if (isOptional)
                Text(
                  'Opcional',
                  style: AppTypo.p5(color: AppColors.lightGrayColor),
                ),
            ],
          ),
          Spacing(height: 8)
        ],
        AppField(
          controller: textEditingController,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          obscureText: isObscure,
          hintText: hintText,
          verticalPadding: verticalPadding,
          horizontalPadding: horizontalPadding,
          fieldTextStyle: fieldTextStyle,
          isBigTextField: isBigText,
          prefixIcon: prefixIcon,
          focusNode: focusNode,
          suffixIcon: isPassword
              ? Padding(
                  padding: EdgeInsets.only(
                    right: SizeConverter.relativeWidth(8),
                  ),
                  child: GestureDetector(
                    onTap: onPressedIcon,
                    child: Icon(
                      isObscure ? LineAwesomeIcons.eye_1 : LineAwesomeIcons.eye_slash,
                      color: AppColors.lightGrayColor,
                      size: SizeConverter.relativeWidth(24),
                    ),
                  ),
                )
              : null,
          errorText: errorText,
        ),
      ],
    );
  }
}
