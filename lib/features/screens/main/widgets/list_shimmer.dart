import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: SizeConverter.relativeHeight(16),
          horizontal: SizeConverter.relativeWidth(16),
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: SizeConverter.relativeHeight(index == 0 ? 0 : 16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConverter.relativeWidth(45),
                  width: SizeConverter.relativeWidth(45),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightGrayColor,
                  ),
                ),
                Spacing(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: SizeConverter.relativeHeight(4),
                      ),
                      width: SizeConverter.relativeWidth(140),
                      height: SizeConverter.relativeWidth(8),
                      color: AppColors.lightGrayColor,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: SizeConverter.relativeHeight(4)),
                      width: SizeConverter.relativeWidth(100),
                      height: SizeConverter.relativeWidth(8),
                      color: AppColors.lightGrayColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
