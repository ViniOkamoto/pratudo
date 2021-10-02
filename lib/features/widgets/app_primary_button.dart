import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isLoading;
  final Function()? onPressed;
  final double height;
  const AppPrimaryButton({
    this.icon,
    this.onPressed,
    required this.text,
    this.height = 50,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: SizeConverter.relativeWidth(height),
            child: ElevatedButton(
              onPressed: onPressed,
              child: Visibility(
                visible: !isLoading,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        size: SizeConverter.fontSize(24),
                        color: AppColors.whiteColor,
                      ),
                      Spacing(width: 8),
                    ],
                    Text(
                      text,
                      style: AppTypo.buttonText(color: AppColors.whiteColor),
                    ),
                  ],
                ),
                replacement: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
