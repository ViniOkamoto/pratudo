import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'portion_model.g.dart';

@HiveType(typeId: 6)
class PortionModel {
  @HiveField(0)
  @observable
  late final double value;
  @HiveField(1)
  @observable
  late final String? unitOfMeasure;

  PortionModel({
    this.value = 0,
    this.unitOfMeasure,
  });

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
