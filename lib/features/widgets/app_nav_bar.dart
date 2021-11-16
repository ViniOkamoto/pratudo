import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/enums/nav_bar_items_enum.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/main_store.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class AppNavBar extends StatelessWidget {
  final MainStore mainStore;
  final UserProgressStore userProgressStore;
  AppNavBar({
    required this.mainStore,
    required this.userProgressStore,
  });
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        height: SizeConverter.relativeWidth(64),
        padding: EdgeInsets.only(
          left: SizeConverter.relativeWidth(24),
          right: SizeConverter.relativeWidth(16),
          top: SizeConverter.relativeHeight(8),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, -1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavButton(
                    item: NavBarItemEnum.EXPLORE,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItemEnum.EXPLORE),
                  ),
                  _NavButton(
                    item: NavBarItemEnum.SEARCH,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItemEnum.SEARCH),
                  ),
                  _NavButton(
                    item: NavBarItemEnum.FAVORITES,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItemEnum.FAVORITES),
                  ),
                  _NavButton(
                    item: NavBarItemEnum.PROFILE,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItemEnum.PROFILE),
                  ),
                ],
              ),
            ),
            Observer(
              builder: (context) {
                if (userProgressStore.isLoading || userProgressStore.hasError) return Container();
                return _UserLevel(
                  level: userProgressStore.userProgress!.level,
                  percentage: userProgressStore.userProgress!.experience.percentage,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

class _UserLevel extends StatelessWidget {
  const _UserLevel({
    Key? key,
    required this.level,
    required this.percentage,
  }) : super(key: key);

  final int level;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircularPercentIndicator(
            radius: SizeConverter.fontSize(30),
            animation: true,
            animationDuration: 1200,
            backgroundColor: AppColors.lightestGrayColor,
            lineWidth: 4,
            circularStrokeCap: CircularStrokeCap.round,
            percent: percentage,
            progressColor: AppColors.blueColor,
            center: Text(
              "$level",
              style: AppTypo.p3(color: AppColors.blueColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavBarItemEnum item;
  final NavBarItemEnum currentItem;
  final VoidCallback onTap;

  const _NavButton({
    required this.onTap,
    required this.item,
    required this.currentItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            item.icon,
            color: currentItem == item ? AppColors.highlightColor : AppColors.lightGrayColor,
            size: SizeConverter.fontSize(35),
          ),
          Spacing(height: 4),
          Flexible(
            child: Text(
              item.enumToString,
              style: AppTypo.smallText(
                color: currentItem == item ? AppColors.highlightColor : AppColors.lightGrayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
