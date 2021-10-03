import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class CarrouselShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
