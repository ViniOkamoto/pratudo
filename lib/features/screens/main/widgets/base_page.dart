import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.highlightColor,
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: SizeConverter.relativeHeight(16),
        ),
        physics: BouncingScrollPhysics(),
        children: [
          child,
        ],
      ),
    );
  }
}
