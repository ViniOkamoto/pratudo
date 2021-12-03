import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:pratudo/features/models/time_model.dart';

part 'step_model.g.dart';

enum StepEnum {
  DEFAULT,
  WITH_TIME,
}

@HiveType(typeId: 10)
class StepModel {
  @HiveField(0)
  late final String step;
  @HiveField(1)
  late final List<StepByStepCreation> items;
  @HiveField(2)
  late final TimeModel time;

  StepModel({
    required this.step,
    required this.items,
    required this.time,
  });

  StepModel.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    items = List.from(json['items']).map((e) {
      if (e['time'] != null) {
        return StepByStepWithTimeCreation.fromJson(e);
      }
      return StepByStepCreation.fromJson(e);
    }).toList();
    time = TimeModel.fromJson(json['time']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['step'] = step;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['time'] = time.toJson();

    return _data;
  }
}

@HiveType(typeId: 11)
class StepByStepCreation {
  late final Key? key;
  @HiveField(4)
  late final String? description;
  StepByStepCreation({
    this.key,
    this.description,
  });

  StepByStepCreation.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    return _data;
  }

  StepByStepCreation copyWith({
    String? description,
  }) {
    return StepByStepCreation(
      key: key,
      description: description ?? this.description,
    );
  }
}

@HiveType(typeId: 12)
class StepByStepWithTimeCreation extends StepByStepCreation {
  @HiveField(5)
  late final TimeModel? time;
  StepByStepWithTimeCreation({
    Key? key,
    String? description,
    this.time,
  }) : super(description: description, key: key);

  factory StepByStepWithTimeCreation.fromJson(Map<String, dynamic> json) =>
      StepByStepWithTimeCreation(
        time: TimeModel.fromJson(json['time']),
        description: json['description'],
      );

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['time'] = time!.toJson();
    return data;
  }

  StepByStepWithTimeCreation copyWith({
    String? description,
    TimeModel? time,
  }) {
    return StepByStepWithTimeCreation(
      key: key,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }
}
