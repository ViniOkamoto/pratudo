import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

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
              color: errorText != null ? AppColors.redProgressColor : AppColors.darkColor,
            ),
          ),
          Spacing(height: 8)
        ],
        TextField(
          controller: textEditingController,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          obscureText: isObscure,
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
            hintStyle: AppTypo.p2(color: AppColors.lightGrayColor),
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
              color: AppColors.redProgressColor,
            ),
          ),
        ),
      ],
    );
  }
}
