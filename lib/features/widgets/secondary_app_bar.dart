import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_icon_button.dart';

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
                AppIconButton(
                  onTap: () => Navigator.pop(context),
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
