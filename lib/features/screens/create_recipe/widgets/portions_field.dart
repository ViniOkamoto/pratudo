import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_icon_button.dart';

class PortionsField extends StatelessWidget {
  const PortionsField({
    required this.portionValue,
    required this.onTapMore,
    required this.onTapLess,
  });

  final int portionValue;
  final VoidCallback onTapMore;
  final VoidCallback onTapLess;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Porções",
          style: AppTypo.p3(color: AppColors.darkColor),
        ),
        Container(
          child: Row(
            children: [
              AppIconButton(
                onTap: onTapLess,
                iconSize: 16,
                iconData: LineAwesomeIcons.minus,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConverter.relativeWidth(16),
                ),
                child: Text(
                  "$portionValue ${portionValue > 1 ? 'Pessoas' : 'Pessoa'}",
                  style: AppTypo.p3(color: AppColors.darkerColor),
                ),
              ),
              AppIconButton(
                onTap: onTapMore,
                iconSize: 16,
                iconData: LineAwesomeIcons.plus,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
