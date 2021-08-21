import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/constants.dart';
import 'package:pratudo/core/theme/colors.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: Constants.fontFamily,
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(AppColors.highlightColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.lightHighlightColor; // Disabled color
          }
          return AppColors.darkHighlightColor; // Regular color
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
  ),
);

final List<BoxShadow> blueCardShadow = [
  BoxShadow(
    color: Color(0xBFC1D6F5),
    blurRadius: 10,
    offset: Offset(2, 4),
  ),
];
