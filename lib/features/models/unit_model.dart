import 'package:hive/hive.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';

part 'unit_model.g.dart';

@HiveType(typeId: UnitHiveHelper.type)
class UnitModel extends HiveObject {
  @HiveField(UnitHiveHelper.keyUnitField)
  final String key;
  @HiveField(UnitHiveHelper.abbreviationUnitField)
  final String abbreviation;
  @HiveField(UnitHiveHelper.translateUnitField)
  final String translate;

  UnitModel({
    required this.key,
    required this.abbreviation,
    required this.translate,
  });

  static UnitModel fromJson(Map<String, dynamic> json) => UnitModel(
        key: json['key'],
        abbreviation: json['abbreviation'],
        translate: json['translate'],
      );

  static List<UnitModel> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
