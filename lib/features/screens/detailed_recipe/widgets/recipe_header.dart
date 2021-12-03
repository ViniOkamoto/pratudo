import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/icon_with_text.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class RecipeHeader extends StatelessWidget {
  const RecipeHeader({
    Key? key,
    required this.name,
    required this.rate,
    required this.ownerName,
    this.preparations,
    required this.portions,
    this.comments,
  }) : super(key: key);
  final String name;
  final double rate;
  final String ownerName;
  final int? preparations;
  final String portions;
  final int? comments;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: AppTypo.h1(color: AppColors.darkestColor),
            ),
            Spacing(width: 4),
            Icon(
              LineAwesomeIcons.star_1,
              size: SizeConverter.fontSize(20),
              color: AppColors.yellowColor,
            ),
            Text(
              '($rate)',
              style: AppTypo.p3(color: AppColors.greyColor),
            ),
          ],
        ),
        CustomText(
          text: 'Feito por: *$ownerName*',
          style: AppTypo.p4(color: AppColors.darkColor),
        ),
        if (preparations != null)
          Text(
            '$preparations visualizações',
            style: AppTypo.p4(color: AppColors.darkColor),
          ),
        Spacing(height: 8),
        IconWithText(
          icon: LineAwesomeIcons.user,
          color: AppColors.orangeColor,
          text: portions,
          textStyle: AppTypo.p5(color: AppColors.orangeColor),
          iconSize: 20,
        ),
        if (comments != null) ...[
          Spacing(height: 4),
          IconWithText(
            icon: LineAwesomeIcons.sms,
            color: AppColors.blueColor,
            text: '$comments Comentários',
            textStyle: AppTypo.p5(color: AppColors.blueColor),
            iconSize: 20,
          ),
        ]
      ],
    );
  }
}
