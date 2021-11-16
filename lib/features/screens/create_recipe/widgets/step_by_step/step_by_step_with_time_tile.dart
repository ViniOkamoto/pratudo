import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/recipe_creation_model.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/step_by_step/step_by_step_tile.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepByStepWithTimeTile extends StatefulWidget {
  final StepByStepWithTime step;
  final int index;

  StepByStepWithTimeTile({
    Key? key,
    required this.step,
    required this.index,
  }) : super(key: key);

  @override
  State<StepByStepWithTimeTile> createState() => _StepByStepWithTimeTileState();
}

class _StepByStepWithTimeTileState extends State<StepByStepWithTimeTile> {
  final TextEditingController _controller = TextEditingController();

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
          Expanded(
            child: AppTextField(
              isBigText: true,
              focusNode: textFieldFocusNode,
              prefixIcon: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  // Unfocus all focus nodes
                  textFieldFocusNode.unfocus();

                  // Disable text field's focus node request
                  textFieldFocusNode.canRequestFocus = false;

                  // Do your stuff
                  print("Thanks for the solution");

                  //Enable the text field's focus node request after some delay
                  Future.delayed(Duration(milliseconds: 100), () {
                    textFieldFocusNode.canRequestFocus = true;
                  });
                },
                child: Icon(
                  LineAwesomeIcons.clock,
                  size: SizeConverter.fontSize(18),
                  color: AppColors.blueColor,
                ),
              ),
              hintText: "Corte os ingredientes",
              textEditingController: _controller,
              onChanged: (onChanged) {},
              errorText: null,
            ),
          ),
          Spacing(width: 8),
          Icon(
            LineAwesomeIcons.alternate_trash,
            size: SizeConverter.fontSize(24),
            color: AppColors.lightGrayColor,
          ),
        ],
      ),
    );
  }
}
