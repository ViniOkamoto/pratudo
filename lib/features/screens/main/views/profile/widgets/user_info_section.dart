import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/views/profile/widgets/profile_circle.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileCircle(),
        Spacing(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem Ipsum',
              style: AppTypo.h2(color: AppColors.darkColor),
            ),
            Text(
              'Lorem Ipsum',
              style: AppTypo.p3(color: AppColors.highlightColor),
            ),
            Spacing(height: 8),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConverter.relativeWidth(8),
                vertical: SizeConverter.relativeWidth(2),
              ),
              decoration: BoxDecoration(
                color: AppColors.highlightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Nível 10',
                style: AppTypo.p5(color: AppColors.whiteColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
