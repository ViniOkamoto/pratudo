import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/features/models/recipe/recipe_creation_model.dart';
import 'package:pratudo/features/screens/create_recipe/create_recipe_page.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_tile.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_with_time_tile.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepByStepSection extends StatefulWidget {
  @override
  State<StepByStepSection> createState() => _StepByStepSectionState();
}

class _StepByStepSectionState extends State<StepByStepSection> {
  List<StepByStep> steps = [
    StepByStep(key: UniqueKey(), description: "Teste"),
    StepByStepWithTime(
      key: UniqueKey(),
      time: Time(
        value: 2,
        unit: 'SECONDS',
      ),
      description: 'Descrição testeaaaaaaaaaa',
    ),
    StepByStepWithTime(
      key: UniqueKey(),
      time: Time(
        value: 4,
        unit: 'SECONDS',
      ),
      description: 'Descrição teste',
    ),
    StepByStep(
      key: UniqueKey(),
      description: "Testeaaaaaaaaaaaaa",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Passo a passo",
                style: AppTypo.p3(color: AppColors.darkestColor),
              ),
              Spacing(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ReorderableListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          if (steps[index] is StepByStepWithTime) {
                            return StepByStepWithTimeTile(
                              key: ValueKey(steps[index].key),
                              step: steps[index] as StepByStepWithTime,
                              index: index,
                            );
                          }
                          return StepByStepTile(
                            key: ValueKey(steps[index].key),
                            step: steps[index],
                            index: index,
                          );
                        },
                        // The reorder function
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex = newIndex - 1;
                            }
                            final element = steps.removeAt(oldIndex);
                            steps.insert(newIndex, element);
                          });
                        }),
                  ),
                ],
              ),
              Spacing(height: 16),
              AddOption(
                onTap: () {},
                label: "Adicionar mais um passo",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
