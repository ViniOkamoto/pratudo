import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/image_string.dart';
import 'package:transparent_image/transparent_image.dart';

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
            BoxShadow(color: AppColors.blackWith25Opacity, blurRadius: 4, offset: Offset(0, 2)),
          ],
          shape: BoxShape.circle,
        ),
        child: _CircleImage());
  }
}

class _CircleImage extends StatelessWidget {
  const _CircleImage({
    this.image = profileTest,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: FadeInImage(
        fit: BoxFit.scaleDown,
        placeholder: MemoryImage(kTransparentImage),
        image: MemoryImage(ImageHelper.convertBase64ToImage(image)),
      ),
    );
  }
}
