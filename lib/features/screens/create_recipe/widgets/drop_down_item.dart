import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class DropdownItem extends StatelessWidget {
  final String? image64Icon;
  final String label;

  const DropdownItem({
    this.image64Icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (image64Icon != null && image64Icon!.isNotEmpty) ...[
          Container(
            width: SizeConverter.relativeWidth(16),
            height: SizeConverter.relativeWidth(16),
            child: Image.memory(
              ImageHelper.convertBase64ToImage(image64Icon!),
            ),
          ),
          Spacing(width: 8),
        ],
        Text(
          label,
          style: AppTypo.p2(color: AppColors.darkColor),
        ),
      ],
    );
  }
}
