import 'package:flutter_countdown_timer/index.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';

part 'step_store.g.dart';

class StepStore = _StepStoreBase with _$StepStore;

abstract class _StepStoreBase with Store {
  AudioPlayer audio = AudioPlayer();

  @observable
  CountdownController? controller;

  @observable
  StepByStepWithTimeCreation? stepWithTime;

  @observable
  Duration? stepTime;
  checkIfIsAStepWithTime(StepByStepCreation step) {
    if (step is StepByStepWithTimeCreation) {
      stepWithTime = step;
      stepTime = Duration(minutes: stepWithTime!.time!.value);
      controller = CountdownController(duration: stepTime, onEnd: onEnd);
    }
  }

  startTimer() {
    if (!controller!.isRunning) {
      controller?.start();
    }
  }

  pauseTimer() {
    if (controller!.isRunning) {
      controller?.stop();
    }
  }

  restartTimer() {
    if (controller!.isRunning) {
      controller?.stop();
    }
    controller!.value = stepTime!.inMilliseconds;
  }

  onEnd() async {
    await audio.setAsset('assets/sound/kitchen_alarm.mp3');
    audio.play();
  }
}
