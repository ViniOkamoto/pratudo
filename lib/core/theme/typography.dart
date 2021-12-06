import 'package:flutter/material.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class AppTypo {
  static TextStyle h1({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(24),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle h2({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(16),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle h3({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(14),
      fontWeight: FontWeight.w500,
      height: 1,
    );
  }

  static TextStyle p1({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(24),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle p2({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(16),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle p3({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(14),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle p4({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(12),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle p5({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(10),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle a1({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(12),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle a2({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(8),
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle smallText({
    color = Colors.black,
    fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(8),
      fontWeight: fontWeight,
    );
  }

  static TextStyle buttonText({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(16),
      letterSpacing: 0.8,
      fontWeight: FontWeight.w500,
    );
  }
}
