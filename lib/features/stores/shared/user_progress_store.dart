import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';
import 'package:pratudo/features/models/user_information_model.dart';
import 'package:pratudo/features/models/user_progress/user_progress_model.dart';
import 'package:pratudo/features/repositories/gamefication_repository.dart';

part 'user_progress_store.g.dart';

class UserProgressStore = _UserProgressStoreBase with _$UserProgressStore;

abstract class _UserProgressStoreBase with Store {
  final GamificationRepository _repository;
  _UserProgressStoreBase(this._repository);

  @observable
  UserProgressModel? userProgress;

  @observable
  UserProgressModel? prevUserProgress;

  @observable
  UserInformationModel? userInformationModel;

  @observable
  ExperienceGainedModel? experienceGainedModel;

  @observable
  bool hasError = false;

  @observable
  bool isLoading = false;

  userGainedXp(ExperienceGainedModel experience) async {
    experienceGainedModel = experience;
    await getUserProgress();
    experienceGainedModel = null;
  }

  getUserProgress() async {
    hasError = false;
    isLoading = true;
    final result = await _repository.getUserProgress();
    final userInformation = await _repository.getUserInformation();

    result.fold(
      (l) => hasError = true,
      (r) {
        userProgress = r;
        prevUserProgress = r;
      },
    );

    userInformation.fold(
      (l) => null,
      (r) => userInformationModel = r,
    );

    isLoading = false;
  }
}
