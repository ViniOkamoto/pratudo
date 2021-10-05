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
  final bool isObscure;
  final bool isPassword;
  final Function()? onPressedIcon;

  const AppTextField({
    required this.hintText,
    required this.textEditingController,
    required this.onChanged,
    this.onPressedIcon,
    this.inputFormatters,
    this.errorText,
    this.isObscure = false,
    this.isPassword = false,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTypo.p3(
              color: errorText != null ? AppColors.redColor : AppColors.darkColor,
            ),
          ),
          Spacing(height: 8)
        ],
        AppField(
          controller: textEditingController,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          obscureText: isObscure,
          hintText: hintText,
          prefixIcon: isPassword
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
