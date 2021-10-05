import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/views/profile/widgets/profile_circle.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    Key? key,
    required this.userProgressStore,
  }) : super(key: key);

  final UserProgressStore userProgressStore;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
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
              Visibility(
                visible: userProgressStore.userProgress != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProgressStore.userProgress?.title ?? '',
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
                        'Nível ${userProgressStore.userProgress?.level ?? ''}',
                        style: AppTypo.p5(color: AppColors.whiteColor),
                      ),
                    ),
                  ],
                ),
                replacement: LoadingShimmer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacing(height: 2),
                      Container(
                        width: 60,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Spacing(height: 10),
                      Container(
                        width: 40,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
