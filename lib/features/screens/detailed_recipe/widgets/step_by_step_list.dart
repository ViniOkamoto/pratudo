import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';
import 'package:pratudo/features/widgets/icon_with_text.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepByStepList extends StatelessWidget {
  const StepByStepList({
    Key? key,
    required this.stepName,
    required this.steps,
  }) : super(key: key);

  final String stepName;
  final List<StepByStepCreation> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConverter.relativeHeight(8),
          ),
          child: Text(
            stepName,
            style: AppTypo.p3(color: AppColors.darkestColor),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            StepByStepCreation step = steps[index];
            return StepRow(
              step: step,
              index: index,
            );
          },
          itemCount: steps.length,
          separatorBuilder: (context, index) => Spacing(height: 8),
        ),
      ],
    );
  }
}

class StepRow extends StatelessWidget {
  const StepRow({
    Key? key,
    required this.step,
    required this.index,
  }) : super(key: key);

  final StepByStepCreation step;
  final int index;

  @override
  Widget build(BuildContext context) {
    StepByStepWithTimeCreation? stepWithTime =
        step is StepByStepWithTimeCreation
            ? step as StepByStepWithTimeCreation
            : null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1),
          child: Text(
            '${index + 1}.',
            style: AppTypo.h3(color: AppColors.orangeColor),
          ),
        ),
        Spacing(width: 4),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.description!,
                style: AppTypo.p3(color: AppColors.darkColor),
              ),
              if (step is StepByStepWithTimeCreation) ...[
                Spacing(height: 4),
                IconWithText(
                  text: stepWithTime!.time!.convertTimeToString(),
                  icon: LineAwesomeIcons.clock_1,
                  color: AppColors.blueColor,
                  iconSize: 14,
                  textStyle: AppTypo.p4(color: AppColors.blueColor),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
