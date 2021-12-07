import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/image_string.dart';

class ProfileCircle extends StatelessWidget {
  final double size;
  ProfileCircle({this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConverter.relativeWidth(size),
      height: SizeConverter.relativeWidth(size),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.blackWith25Opacity,
              blurRadius: 4,
              offset: Offset(0, 2)),
        ],
        image: DecorationImage(
          fit: BoxFit.scaleDown,
          scale: size == 64 ? 1.4 :size == 24 ? 3 : 2,
          image: MemoryImage(
            ImageHelper.convertBase64ToImage(profileTest),
          ),
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
