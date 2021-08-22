import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CleanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CleanAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacing(width: 8),
        IconButton(
          onPressed: () => Navigator.pop(context),
          iconSize: SizeConverter.fontSize(20),
          color: AppColors.highlightColor,
          icon: Container(
            width: SizeConverter.relativeWidth(30),
            height: SizeConverter.relativeWidth(30),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightHighlightColor,
                width: SizeConverter.relativeWidth(1),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                LineAwesomeIcons.arrow_left,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
