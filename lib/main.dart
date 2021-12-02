import 'package:flutter/material.dart';
import 'package:pratudo/core/app.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/services/hive/hive_service.dart';

void main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  final HiveService hiveService = serviceLocator<HiveService>();
  await hiveService.init();

  runApp(PratudoApp());
}
