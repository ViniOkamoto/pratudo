import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_field.dart';

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
    return AppField(
      controller: textEditingController,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      hintText: hintText,
      prefixIcon: Icon(
        LineAwesomeIcons.search,
        color: AppColors.lightHighlightColor,
        size: SizeConverter.fontSize(24),
      ),
    );
  }
}
