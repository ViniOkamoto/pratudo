import 'package:flutter/material.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class Spacing extends StatelessWidget {
  final double width;
  final double height;
  const Spacing({this.width = 0, this.height = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConverter.relativeWidth(width),
      height: SizeConverter.relativeHeight(height),
    );
  }
}
