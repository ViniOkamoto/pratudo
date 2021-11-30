import 'package:pratudo/features/models/recipe/step_model.dart';

class MethodOfPreparationModel {
  MethodOfPreparationModel({
    required this.steps,
  });
  late final List<StepModel> steps;

  MethodOfPreparationModel.fromJson(Map<String, dynamic> json) {
    steps = List.from(json['steps']).map((e) => StepModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['steps'] = steps.map((e) => e.toJson()).toList();
    return _data;
  }
}
