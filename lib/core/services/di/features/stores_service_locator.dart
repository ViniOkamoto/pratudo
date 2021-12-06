import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';
import 'package:pratudo/features/repositories/detailed_recipe_repository.dart';
import 'package:pratudo/features/repositories/recipe_helpers_repository.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/rate_and_comment/rate_and_comment_store.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/stores/shared/user_information_store.dart';

Future<void> setupStoresLocator() async {
  serviceLocator.registerLazySingleton<UserInformationStore>(
    () => UserInformationStore(serviceLocator.get<AuthenticationRepository>()),
  );

  serviceLocator.registerFactory<SearchStore>(
    () => SearchStore(serviceLocator.get<RecipeRepository>()),
  );

  serviceLocator.registerLazySingleton<RecipeHelpersStore>(
    () => RecipeHelpersStore(serviceLocator.get<RecipeHelperRepository>()),
  );

  serviceLocator.registerFactory<RateAndCommentStore>(
    () => RateAndCommentStore(
      serviceLocator<DetailedRecipeRepository>(),
      serviceLocator<GamificationObserver>(),
    ),
  );
}
