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
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: AppColors.darkHighlightColor,
      side: BorderSide(
        color: AppColors.darkHighlightColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
);
