import 'package:flutter/material.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class DetailedRecipeLoading extends StatelessWidget {
  const DetailedRecipeLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(16),
          vertical: SizeConverter.relativeHeight(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HorizontalListShimmer(
                    space: 8,
                    height: 15,
                    width: 80,
                  ),
                  Spacing(height: 8),
                  ShimmerBox(
                    height: 20,
                    width: 150,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    height: 15,
                    width: 100,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    height: 8,
                    width: 55,
                  ),
                  Spacing(height: 8),
                  ShimmerBox(
                    height: 10,
                    width: 55,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    height: 10,
                    width: 80,
                  ),
                  Spacing(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerBox(
                        height: 40,
                      ),
                      ShimmerBox(
                        height: 40,
                      ),
                      ShimmerBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Spacing(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ShimmerBox(
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  Spacing(height: 24),
                  ShimmerBox(
                    height: 16,
                  ),
                  Spacing(height: 8),
                  ShimmerBox(
                    width: 120,
                    height: 12,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    width: 140,
                    height: 12,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    width: 80,
                    height: 12,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    width: 180,
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
