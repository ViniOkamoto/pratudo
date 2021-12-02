import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/hive/boxes.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/features/models/unit_model.dart';

class HiveService {
  final HiveInterface hive;
  final Boxes boxes;
  HiveService({required this.hive, required this.boxes});

  Future<void> init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    hive
      ..init(directory.path)
      ..registerAdapter(UnitModelAdapter());

    await hive.openBox<UnitModel>(HiveNamesHelper.pratudoDatabase);
  }

  Future<Box> getBox({required String typeString}) async {
    try {
      Box box;
      switch (typeString) {
        case HiveNamesHelper.pratudoDatabase:
          box = boxes.getUnitsOfMeasure();
          break;
        default:
          throw LocalCacheException(errorText: "Error interno");
      }
      return box;
    } catch (e) {
      throw LocalCacheException(errorText: "Erro ao buscar dados");
    }
  }
}
