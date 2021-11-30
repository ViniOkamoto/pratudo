import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/recipe_section.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_tile.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_with_time_tile.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepByStepSection extends StatefulWidget {
  final List<StepByStepCreation> steps;
  final List<TextEditingController>? controllers;
  final VoidCallback onTapAdd;
  final Function(int, int) onTapDelete;
  final Function(int, int, int) reorderStep;
  final Function(String, int, int) onChangedStepDescription;
  final Function(Duration, int, int) onChangedTime;
  final int sectionIndex;

  StepByStepSection({
    required this.steps,
    required this.controllers,
    required this.onTapAdd,
    required this.onTapDelete,
    required this.reorderStep,
    required this.sectionIndex,
    required this.onChangedStepDescription,
    required this.onChangedTime,
  });

  @override
  State<StepByStepSection> createState() => _StepByStepSectionState();
}

class _StepByStepSectionState extends State<StepByStepSection> {
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
                      itemCount: widget.steps.length,
                      itemBuilder: (context, index) {
                        if (widget.steps[index] is StepByStepWithTimeCreation) {
                          return StepByStepWithTimeTile(
                            key: ValueKey(widget.steps[index].key),
                            step: widget.steps[index]
                                as StepByStepWithTimeCreation,
                            onTapDelete: () => widget.onTapDelete(
                              widget.sectionIndex,
                              index,
                            ),
                            onChanged: (value) =>
                                widget.onChangedStepDescription(
                              value,
                              widget.sectionIndex,
                              index,
                            ),
                            onChangedTime: (value) => widget.onChangedTime(
                              value,
                              widget.sectionIndex,
                              index,
                            ),
                            time: (widget.steps[index]
                                    as StepByStepWithTimeCreation)
                                .time,
                            textEditingController: widget.controllers![index],
                            index: index,
                          );
                        }
                        return StepByStepTile(
                          key: ValueKey(widget.steps[index].key),
                          step: widget.steps[index],
                          onTapDelete: () => widget.onTapDelete(
                            widget.sectionIndex,
                            index,
                          ),
                          textEditingController: widget.controllers![index],
                          onChanged: (value) => widget.onChangedStepDescription(
                            value,
                            widget.sectionIndex,
                            index,
                          ),
                          index: index,
                        );
                      },
                      // The reorder function
                      onReorder: (oldIndex, newIndex) => widget.reorderStep(
                        widget.sectionIndex,
                        oldIndex,
                        newIndex,
                      ),
                    ),
                  ),
                ],
              ),
              Spacing(height: 16),
              AddOption(
                onTap: widget.onTapAdd,
                label: "Adicionar mais um passo",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
