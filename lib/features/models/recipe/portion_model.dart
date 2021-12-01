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

  dynamic get quantity {
    List<String> decimalValue = value.toStringAsPrecision(2).split('.');
    double decimal = double.parse(decimalValue.last);
    return decimal > 0 ? value : value.round();
  }

  PortionModel.fromJson(Map<String, dynamic> json) {
    value = double.parse(json['value']);
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
