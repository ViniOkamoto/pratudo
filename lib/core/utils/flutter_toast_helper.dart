import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class FlutterToastHelper {
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  FlutterToastHelper({
    required this.text,
    this.backgroundColor = AppColors.greyColor,
    this.textColor = AppColors.whiteColor,
  }) {
    show();
  }
  show() {
    cancel();
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

  factory FlutterToastHelper.successToast({required String text}) => FlutterToastHelper(
        text: text,
        textColor: AppColors.whiteColor,
        backgroundColor: AppColors.greenColor,
      );

  factory FlutterToastHelper.failToast({required String? text}) {
    return FlutterToastHelper(
      text: text,
      textColor: AppColors.whiteColor,
      backgroundColor: AppColors.redColor,
    );
  }

  factory FlutterToastHelper.neutralToast({required String text}) {
    return FlutterToastHelper(text: text);
  }
  static cancel() {
    return Fluttertoast.cancel();
  }
}
