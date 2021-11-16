import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class FormDropdownField<T> extends StatelessWidget {
  final Function(T?) onChanged;
  final T? value;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final String? labelText;
  final String? errorText;
  final double height;
  final TextStyle? Function({dynamic color})? fieldTextStyle;
  final Color? errorBorderSide;

  const FormDropdownField({
    required this.hintText,
    this.labelText,
    required this.onChanged,
    required this.items,
    this.height = 50,
    this.value,
    this.errorText,
    this.fieldTextStyle,
    this.errorBorderSide,
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
            ],
          ),
          Spacing(height: 8),
        ],
        Container(
          height: SizeConverter.relativeWidth(height),
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            isDense: true,
            elevation: 0,
            items: items,
            onChanged: onChanged,
            icon: Icon(
              LineAwesomeIcons.angle_down,
              color: AppColors.highlightColor,
            ),
            iconSize: SizeConverter.fontSize(12),
            value: value,
            style: fieldTextStyle != null
                ? fieldTextStyle!(color: AppColors.darkestColor)
                : AppTypo.p2(
                    color: AppColors.darkestColor,
                  ),
            decoration: InputDecoration(
              fillColor: AppColors.lightestGrayColor,
              filled: true,
              isDense: false,
              hintText: hintText,
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
              errorStyle: fieldTextStyle != null
                  ? fieldTextStyle!(color: AppColors.redColor)
                  : AppTypo.p2(
                      color: AppColors.redColor,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
