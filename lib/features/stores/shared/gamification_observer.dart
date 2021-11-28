import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';

class GamificationObserver {
  final UserProgressStore _userProgressStore;
  GamificationObserver(this._userProgressStore);

  Future<Either<Failure, ExperienceGainedModel>> callWithGamificationResponse(
      Future<Either<Failure, ExperienceGainedModel>> future) {
    return future.then(
      (value) {
        if (value.isRight()) {
          value.fold((l) => null, (r) => _userProgressStore.userGainedXp(r));
        }

        return future;
      },
    );
  }
}
