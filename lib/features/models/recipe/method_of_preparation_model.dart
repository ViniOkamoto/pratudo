import 'package:hive/hive.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';

part 'method_of_preparation_model.g.dart';

@HiveType(typeId: 9)
class MethodOfPreparationModel {
  @HiveField(0)
  late final List<StepModel> steps;

  MethodOfPreparationModel({
    required this.steps,
  });

  MethodOfPreparationModel.fromJson(Map<String, dynamic> json) {
    steps = List.from(json['steps']).map((e) => StepModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['steps'] = steps.map((e) => e.toJson()).toList();
    return _data;
  }
}
