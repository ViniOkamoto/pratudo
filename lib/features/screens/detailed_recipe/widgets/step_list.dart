import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_detailed_sections_title.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/step_by_step_list.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepListSection extends StatelessWidget {
  const StepListSection({
    Key? key,
    required this.steps,
  }) : super(key: key);
  final List<StepModel> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeDetailedSectionsTitle(
          icon: LineAwesomeIcons.mortar_pestle,
          text: 'Passo a passo',
        ),
        ListView.separated(
          padding: EdgeInsets.only(
            left: SizeConverter.relativeWidth(16),
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            StepModel step = steps[index];
            return StepByStepList(
              stepName: step.step,
              steps: step.items,
            );
          },
          separatorBuilder: (context, index) => Spacing(height: 8),
          itemCount: steps.length,
        ),
      ],
    );
  }
}
