import 'package:flutter/material.dart';

class Constants {
  static GlobalKey<NavigatorState> appGlobalKey = GlobalKey<NavigatorState>();
  static const String fontFamily = 'Worksans';
  static const int httpTimeout = 10000;
  static const int receiveTimeout = 10000;
  static const String baseUrl = "https://pratudo-api.herokuapp.com/";
}
