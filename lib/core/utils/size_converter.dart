import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/constants.dart';

class SizeConverter {
  static double factorWidth(double size) {
    double prototypeWidth = 375.0;
    return (size * 100 / prototypeWidth) / 100;
  }

  static double factorHeight(double size) {
    double prototypeHeight = 667.0;
    return (size * 100 / prototypeHeight) / 100;
  }

  static double relativeWidth(double size) {
    return MediaQuery.of(Constants.appGlobalKey.currentContext!).size.width * factorWidth(size);
  }

  static double relativeHeight(double size) {
    return MediaQuery.of(Constants.appGlobalKey.currentContext!).size.height * factorHeight(size);
  }

  static fontSize(double fontSize) {
    return MediaQuery.of(Constants.appGlobalKey.currentContext!).size.width * SizeConverter.factorWidth(fontSize);
  }
}
