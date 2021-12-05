import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';

class StepView extends StatefulWidget {
  final StepByStepCreation step;
  final String sectionName;
  const StepView({
    required this.step,
    required this.sectionName,
  });

  @override
  _StepViewState createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.step.description!,
                  style: AppTypo.p3(color: AppColors.darkColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
