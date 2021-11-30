import 'package:flutter/cupertino.dart';
import 'package:pratudo/features/models/time_model.dart';

enum StepEnum {
  DEFAULT,
  WITH_TIME,
}

class StepModel {
  StepModel({
    required this.step,
    required this.items,
    required this.time,
  });
  late final String step;
  late final List<StepByStepCreation> items;
  late final TimeModel time;

  StepModel.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    items = List.from(json['items'])
        .map((e) => StepByStepCreation.fromJson(e))
        .toList();
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

class StepByStepCreation {
  late final Key? key;
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

class StepByStepWithTimeCreation extends StepByStepCreation {
  late final TimeModel? time;
  StepByStepWithTimeCreation({
    Key? key,
    String? description,
    this.time,
  }) : super(description: description, key: key);

  factory StepByStepWithTimeCreation.fromJson(Map<String, dynamic> json) =>
      StepByStepWithTimeCreation(
        time: TimeModel.fromJson(json['time']),
        description: json['value'],
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
