import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';
import 'package:pratudo/features/widgets/app_text_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class StepByStepTile extends StatefulWidget {
  final StepByStepCreation step;
  final int index;
  final VoidCallback onTapDelete;
  final TextEditingController textEditingController;
  final ValueChanged onChanged;

  StepByStepTile({
    Key? key,
    required this.step,
    required this.index,
    required this.onTapDelete,
    required this.textEditingController,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<StepByStepTile> createState() => _StepByStepTileState();
}

class _StepByStepTileState extends State<StepByStepTile> {
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
              hintText: "Corte os ingredientes",
              textEditingController: widget.textEditingController,
              onChanged: widget.onChanged,
              errorText: null,
            ),
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

class CircleIndex extends StatelessWidget {
  const CircleIndex({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.orangeColor,
        ),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: AppTypo.p4(
            color: AppColors.orangeColor,
          ),
        ),
      ),
    );
  }
}
