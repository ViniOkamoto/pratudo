import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      highlightColor: AppColors.lightestGrayColor,
      baseColor: AppColors.lightGrayColor,
      child: child,
    );
  }
}
