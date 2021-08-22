import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class FlutterToastHelper {
  static showToast({
    String? text,
    Color? backgroundColor = AppColors.redProgressColor,
    Color? textColor = AppColors.whiteColor,
  }) {
    return Fluttertoast.showToast(
      msg: text ?? "Erro inesperado",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: SizeConverter.fontSize(16),
    );
  }
}
