import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
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
      highlightColor: AppColors.whiteColor,
      baseColor: AppColors.lightestGrayColor,
      child: child,
    );
  }
}

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    Key? key,
    this.margin,
    this.height = 25,
    this.width = 100,
  }) : super(key: key);
  final EdgeInsets? margin;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
    );
  }
}

class HorizontalListShimmer extends StatelessWidget {
  const HorizontalListShimmer({
    Key? key,
    this.height = 25,
    this.width = 100,
    this.space = 16,
    this.length = 3,
  }) : super(key: key);

  final double width;
  final double height;
  final double space;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                length,
                (index) => ShimmerBox(
                  margin: EdgeInsets.only(
                    right: SizeConverter.relativeWidth(space),
                  ),
                  width: width,
                  height: height,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
