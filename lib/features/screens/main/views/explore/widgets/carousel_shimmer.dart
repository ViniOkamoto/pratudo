import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CarouselShimmer extends StatelessWidget {
  final bool withoutFilterRow;
  CarouselShimmer({this.withoutFilterRow = false});

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!withoutFilterRow)
            SizedBox(
              height: 25,
              child: Row(children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConverter.relativeWidth(16),
                        ),
                        width: 100,
                        height: 25,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          Spacing(height: withoutFilterRow ? 24 : 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: SizeConverter.relativeWidth(316),
                      child: _LoadingCard(
                        width: 223,
                        height: 200,
                      ),
                    ),
                    Positioned(
                      left: SizeConverter.relativeWidth(316),
                      child: _LoadingCard(
                        width: 223,
                        height: 200,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: _LoadingCard(
                        width: 223,
                        height: 269,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  final double height;
  final double width;

  const _LoadingCard({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConverter.relativeHeight(height),
      width: SizeConverter.relativeWidth(width),
      decoration: BoxDecoration(
        color: AppColors.highlightColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
