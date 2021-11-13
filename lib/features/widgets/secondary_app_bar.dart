import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final List<Widget>? children;
  final VoidCallback? onPressedBackButton;

  SecondaryAppBar({
    this.text,
    this.children,
    this.onPressedBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConverter.relativeWidth(16),
        right: SizeConverter.relativeWidth(24),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  highlightColor: AppColors.lightestHighlightColor,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightHighlightColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      LineAwesomeIcons.arrow_left,
                      size: SizeConverter.fontSize(20),
                      color: AppColors.highlightColor,
                    ),
                  ),
                ),
                Row(
                  children: children ?? [],
                ),
              ],
            ),
          ),
          if (text?.isNotEmpty ?? false)
            Align(
              alignment: Alignment.center,
              child: Text(
                text!,
                style: AppTypo.p2(color: AppColors.highlightColor),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
