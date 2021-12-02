import 'package:hive/hive.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/features/models/unit_model.dart';

class Boxes {
  Box<UnitModel> getUnitsOfMeasure() =>
      Hive.box<UnitModel>(HiveNamesHelper.pratudoDatabase);
}
