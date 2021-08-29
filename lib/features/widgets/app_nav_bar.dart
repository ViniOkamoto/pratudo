import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/enums/nav_bar_items.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/main_store.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class AppNavBar extends StatelessWidget {
  final MainStore mainStore;
  AppNavBar({required this.mainStore});
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
                    item: NavBarItem.EXPLORE,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItem.EXPLORE),
                  ),
                  _NavButton(
                    item: NavBarItem.SEARCH,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItem.SEARCH),
                  ),
                  _NavButton(
                    item: NavBarItem.FAVORITES,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItem.FAVORITES),
                  ),
                  _NavButton(
                    item: NavBarItem.PROFILE,
                    currentItem: mainStore.pageSelected,
                    onTap: () => mainStore.selectPage(NavBarItem.PROFILE),
                  ),
                ],
              ),
            ),
            _UserLevel(),
          ],
        ),
      );
    });
  }
}

class _UserLevel extends StatelessWidget {
  const _UserLevel({
    Key? key,
  }) : super(key: key);

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
            backgroundColor: Colors.white,
            lineWidth: 4,
            circularStrokeCap: CircularStrokeCap.round,
            percent: 0.9,
            progressColor: AppColors.highlightColor,
            center: Text(
              "10",
              style: AppTypo.p3(color: AppColors.highlightColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavBarItem item;
  final NavBarItem currentItem;
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
            navIcon[item],
            color: currentItem == item ? AppColors.highlightColor : AppColors.lightGrayColor,
            size: SizeConverter.fontSize(35),
          ),
          Spacing(height: 4),
          Flexible(
            child: Text(
              navText[item]!,
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
