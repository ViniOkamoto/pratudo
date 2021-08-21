import 'package:flutter/material.dart';
import 'package:pratudo/core/app.dart';
import 'package:pratudo/core/services/di/service_locator.dart';

void main() async {
  await setupLocator();
  runApp(PratudoApp());
}
