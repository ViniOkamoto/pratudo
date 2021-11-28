import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_tile.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepByStepWithTimeTile extends StatefulWidget {
  final StepByStepWithTimeCreation step;
  final int index;
  final VoidCallback onTapDelete;
  final TextEditingController textEditingController;
  final ValueChanged onChanged;
  final Function(Duration) onChangedTime;
  final Time? time;

  StepByStepWithTimeTile({
    Key? key,
    required this.step,
    required this.index,
    required this.onTapDelete,
    required this.textEditingController,
    required this.onChanged,
    required this.onChangedTime,
    required this.time,
  }) : super(key: key);

  @override
  State<StepByStepWithTimeTile> createState() => _StepByStepWithTimeTileState();
}

class _StepByStepWithTimeTileState extends State<StepByStepWithTimeTile> {
  final FocusNode textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConverter.relativeHeight(16),
      ),
      child: Row(
        key: widget.key,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleIndex(index: widget.index),
              Spacing(height: 4),
              Icon(
                LineAwesomeIcons.bars,
                size: SizeConverter.fontSize(16),
                color: AppColors.lightGrayColor,
              ),
            ],
          ),
          Spacing(width: 8),
          DurationTextField(
            textFieldFocusNode: textFieldFocusNode,
            textEditingController: widget.textEditingController,
            onChanged: widget.onChanged,
            onChangedTime: widget.onChangedTime,
            value: widget.time,
          ),
          Spacing(width: 8),
          GestureDetector(
            onTap: widget.onTapDelete,
            child: Icon(
              LineAwesomeIcons.alternate_trash,
              size: SizeConverter.fontSize(24),
              color: AppColors.lightGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DurationTextField extends StatelessWidget {
  const DurationTextField({
    Key? key,
    required this.textFieldFocusNode,
    required this.textEditingController,
    required this.onChanged,
    required this.onChangedTime,
    required this.value,
  }) : super(key: key);

  final FocusNode textFieldFocusNode;
  final TextEditingController textEditingController;
  final ValueChanged onChanged;
  final Function(Duration) onChangedTime;
  final Time? value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            isBigText: true,
            focusNode: textFieldFocusNode,
            prefixIcon: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () async {
                // Unfocus all focus nodes
                textFieldFocusNode.unfocus();
                // Disable text field's focus node request
                textFieldFocusNode.canRequestFocus = false;
                //Enable the text field's focus node request after some delay
                Future.delayed(Duration(milliseconds: 100), () {
                  textFieldFocusNode.canRequestFocus = true;
                });
                Duration? duration = await showDurationPicker(
                  context: context,
                  initialTime: Duration(),
                );
                if (duration != null) {
                  onChangedTime(duration);
                }
              },
              child: Icon(
                LineAwesomeIcons.clock,
                size: SizeConverter.fontSize(18),
                color: AppColors.blueColor,
              ),
            ),
            hintText: "Corte os ingredientes",
            textEditingController: textEditingController,
            onChanged: onChanged,
            errorText: null,
          ),
          Spacing(height: 4),
          Visibility(
            visible: value != null && value?.value != 0,
            child: Text(
              'Tempo de preparo: ${(value ?? Time(
                    unit: '',
                    value: 0,
                  )).convertTimeToString()}',
              style: AppTypo.p5(
                color: AppColors.blueColor,
              ),
            ),
            replacement: Text(
              'Clique no ícone para definir o tempo de preparo do passo',
              style: AppTypo.p5(
                color: AppColors.blueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
