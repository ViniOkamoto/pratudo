import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/text_with_icon.dart';

class NextView extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;

  const NextView({
    Key? key,
    this.color = AppColors.darkHighlightColor,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithIcon(
      onTap: onTap,
      title: title,
      color: color,
      iconIsLeading: false,
      icon: LineAwesomeIcons.angle_right,
    );
  }
}
