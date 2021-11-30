import 'package:mobx/mobx.dart';

class PortionModel {
  PortionModel({
    this.value = 0,
    this.unitOfMeasure,
  });
  @observable
  late final double value;
  @observable
  late final String? unitOfMeasure;

  PortionModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unitOfMeasure = json['unitOfMeasure'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['unitOfMeasure'] = unitOfMeasure;
    return _data;
  }

  PortionModel copyWith({
    double? value,
    String? unitOfMeasure,
  }) {
    return PortionModel(
      value: value ?? this.value,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
    );
  }
}
